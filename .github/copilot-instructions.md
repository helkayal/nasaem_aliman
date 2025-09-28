# AI Coding Agent Instructions for `nasaem_aliman`

Concise, project-specific guidelines so an AI agent can contribute productively. Keep output focused, follow existing patterns, and prefer minimal surface-area changes.

## 1. Project Overview

Flutter app (Dart SDK ^3.8) delivering Islamic content: Quran (surahs, juz, ayahs grouped by page), Azkar categories, and a Sebha (tasbih) counter. Clean architecture-ish layering per feature (data / domain / presentation) with dependency injection via `get_it` (`lib/core/di/di.dart`) and state management using `flutter_bloc` Cubits.

Main entry: `lib/main.dart` → initializes DI then launches `NasaemAlimanApp` wrapping `MaterialApp` inside `ScreenUtilInit` (fixed design size 360x690) to support responsive sizing.

Tabbed root UI: `features/nasaem_aliman_tabs.dart` defines 3 tabs (Sebha, Quran, Azkar) each providing its feature Cubit via a local `BlocProvider` from the service locator.

## 2. Directory & Layer Conventions

- `lib/features/<feature>/data/` → `datasources/`, `models/`, `repositories/` (Impls depend only on datasource). Data sources are currently local JSON loaded with `rootBundle`.
- `lib/features/<feature>/domain/` → `entities/`, `repositories/` (abstract), `usecases/` (simple callable classes wrapping repository methods).
- `lib/features/<feature>/presentatios/` (typo kept: "presentatios") → UI layer: `cubit/`, `screens/`, widgets.
- `lib/core/` → cross-cutting concerns: `di/`, `theme/`, `constants/`, `utils/`, shared `widgets/`.
- Assets: JSON data under `assets/data/` (`surahs.json`, `quran.json`, `juzaa.json`, `pages.json`, `azkar.json`). Images under `assets/images/` referenced in splash / icons config.

Naming patterns:

- Entities vs Models: Models (`...Model`) implement JSON parsing; Entities (`...Entity`) are domain abstractions used by use cases & cubits.
- Use cases named `GetX` with a `call()` method for direct invocation.
- Cubits suffixed `Cubit` with public intent methods (`fetchAllSurahs()`, `loadAzkarCategories()`, etc.).

## 3. Dependency Injection Pattern

`lib/core/di/di.dart` registers (in order): Cubits (factory), UseCases (lazy singleton), Repositories (lazy singleton, interface typed), Datasources (lazy singleton). When adding a feature replicate this vertical slice. Always expose `sl` for retrieval. Provide Cubits in UI using `BlocProvider(create: (_) => sl<SomeCubit>() ...)` and trigger initial load in-line (`..loadSomething()`).

## 4. Data Flow (Example: Quran Surah List)

UI (QuranScreen Cubit init) → `QuranCubit.fetchAllSurahs()` (uses injected `GetAllSurahs`) → `QuranRepositoryImpl.getSurahList()` → `QuranLocalDataSource.getAllSurahs()` → loads & decodes `assets/data/surahs.json` → returns `List<SurahModel>` cast to `List<SurahEntity>` upstream.
Grouping ayahs per Mushaf page uses `pages.json` (see `groupAyahsByPage` in datasource then entity mapping back in repository).

## 5. State Management

Each feature Cubit resides in its feature folder. Follow pattern:

- Internal private mutable fields (e.g. `_count`) not exposed.
- Emit strongly typed states (state classes in companion file or folder). Avoid adding business logic inside UI widgets.
  Add new states as simple classes (no mixins currently) and keep them immutable (final fields) though no `equatable` usage yet—ok to introduce it to reduce boilerplate if consistency maintained across modified states.

## 6. Responsive & Theming

Use `flutter_screenutil` (`ScreenUtilInit` already configured). For sizes inside widgets prefer `.r`, `.sp`, etc. Theme functions: `core/theme/app_theme.dart` (light/dark). Colors centralised in `app_colors.dart` and constants in `core/constants/`.

## 7. Assets & Local Data

All content is local (no network). Access via `rootBundle.loadString('assets/data/<file>.json')`. When introducing new JSON-driven feature:

1. Place file under `assets/data/`.
2. Ensure directory (or glob) is already listed in `pubspec.yaml` (`assets/data/` is included). No need to enumerate each file.
3. Create `<Feature>LocalDataSource` with abstract + impl same pattern.
4. Map JSON to `Model`, convert to `Entity` in repository if crossing into domain.

## 8. Adding a New Feature Slice (Checklist)

- Create `features/<feature>/{data,domain,presentatios}` subfolders.
- Define Entities, abstract Repository, UseCases.
- Implement datasource + repository (impl depends only on datasource, returns Entities where external).
- Register in `di.dart` mirroring Quran/Azkar ordering (Datasource → Repository → UseCases → Cubit(s)). Keep logical grouping comments.
- Provide Cubit via `BlocProvider` in tabs or screen route and trigger initial load with cascade.

## 9. Common Pitfalls / Gotchas

- Folder name `presentatios` is misspelled; stay consistent unless undertaking a repo-wide rename (update imports if you ever correct it).
- Grouping ayahs: `groupAyahsByPage` expects ayah numbers local to surah; ensure provided list matches the surahNumber context to avoid empty pages.
- Some repository methods (e.g. `getSurah`) return concrete Model (`SurahModel`) not `SurahEntity`—maintain this asymmetry unless you refactor all usages.
- State classes lack `Equatable`; adding it selectively could cause inconsistent `BlocBuilder` rebuild behavior if mixed—either adopt globally or skip.

## 10. Build & Run Workflow

Typical local run:

- `flutter pub get`
- `flutter run` (choose device or `-d ios` / `-d macos` / `-d chrome`).
  No custom build scripts present. Splash & launcher icons generated via configured dev dependencies (`flutter_native_splash`, `flutter_launcher_icons`) – regenerate with:
- `dart run flutter_native_splash:create`
- `dart run flutter_launcher_icons`
  Testing: Only default `flutter_test` dependency present; no test suites yet. If adding tests, mirror feature folder structure under `test/features/...`.

## 11. Coding Style Notes

- Lints: `flutter_lints` (default). Follow standard Dart style; avoid unused imports & prefer trailing commas for multi-line widgets.
- Use explicit types in public APIs (avoid `var` for return types in repositories & use cases).
- Keep DI registrations grouped with `//! ---------------- Feature ----------------` comment pattern.

## 12. When Modifying / Extending

Prefer minimal changes touching only one feature slice. If refactoring cross-cutting (e.g., switching repository return types to Entities), update all call sites and adjust DI if signatures change. Always ensure new assets load paths align with existing relative scheme.

## 13. Quick Examples

Register new use case:

```dart
// In di.dart inside feature block
sl.registerLazySingleton(() => GetFoo(sl()));
```

Provide cubit in UI:

```dart
BlocProvider(create: (_) => di.sl<FooCubit>()..loadFoo(), child: const FooScreen());
```

Load JSON:

```dart
final jsonStr = await rootBundle.loadString('assets/data/foo.json');
final list = (json.decode(jsonStr) as List).map((e) => FooModel.fromJson(e));
```

## 14. Keep This Doc Updated

Update sections 2, 3, 8, and 13 when adding new structural elements or conventions. Avoid expanding beyond ~50 lines—replace or prune outdated info instead.

---

Feedback welcome: Are any workflows, generation steps, or feature patterns missing or unclear?
