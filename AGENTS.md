# INSTRUCTIONS & GUIDELINES

Read this guideline carefully to understand the application project background, design system, architecture, technical constraints, and development conventions. All AI assistants, code generators, and code reviewers MUST strictly follow these guidelines.

---

## 1. Project Background & Domain
**Tenir** is a premium mobile application for booking mountain hikes and outdoor adventures in Indonesia (e.g., SIMAKSI entry passes, Open/Private tour packages, equipment rentals, guide/porter hire, catering, and basecamp accommodations).

### Primary Visual & UI Identity
- **Theme:** Analogue "field-journal / photo-print" aesthetic with dark green surfaces and high-contrast accents.
- **Primary Color System:**
  - Base Background: Dark Forest Green (`#1E2B22`)
  - Soft Accents / Card Text: Mint / Sage (`#D7EDE0`)
  - Primary Active CTAs: Safety Orange (`#FF6B35`)
  - Card Highlights / Sticky Bar BG: Light Sage (`#F4F6F0`)
- **UI Elements:** Rounded paper card frames, pushpin accent icons (`📌`), dashed ticket tear-off separators, and official administrative stamps.

---

## 2. Project Structure
The codebase follows a strictly modular structure. **Do NOT introduce top-level folders or custom architecture without explicit user approval.**

```bash
lib/
├── models/             # Business domain entities (Freezed immutable models)
│   ├── hiker.dart
│   ├── ticket.dart
│   ├── transaction.dart
│   └── dto.dart        # DTOs specifically for raw API payload serialization
├── repositories/       # API communication & local storage layer
│   └── mountain_repository.dart
├── services/           # Reusable stateful services (e.g., location, storage, network client)
├── ui/                 # All Flutter UI screens and widgets
│   ├── components/     # Reusable atomic UI widgets (buttons, cards, inputs)
│   │   ├── custom_button.dart
│   │   └── pinned_card.dart
│   └── [feature_name]/ # Feature-specific screens & local components
│       ├── widgets/    # Private UI components exclusive to this page
│       └── [feature]_screen.dart
├── utils/              # Pure static helper functions and constants
└── main.dart
```

---

## 3. Architecture Stack
- **Framework:** Flutter (Mobile-only target)
- **Backend API:** Django Ninja (REST / OpenAPI specification)
- **State Management:** `flutter_riverpod` with `riverpod_generator` annotations
- **Immutability & Codegen:** `freezed` + `json_serializable` (`build_runner`)
- **Auth Strategy:** JWT (Bearer token stored in secure storage)

---

## 4. Coding Standards & Maintainability Rules

### Rule A: Mandatory Componentization (No Monolithic Screens)
Never write large, monolithic widget trees in a single screen file.
- If a build function exceeds **120 lines**, split it into dedicated component files inside `ui/components/` (if shared) or `ui/[feature_name]/widgets/` (if local).
- Isolate complex UI logic (e.g., custom painting, form cards, complex rows) into standalone `StatelessWidget` or `ConsumerWidget` classes.

### Rule B: Model Immutability & Safety
1. **Never modify existing domain models** in `lib/models/` without explicit permission from the user.
2. All data models inside `lib/models/` MUST use the **Freezed** package for immutability.
3. If an API endpoint requires request/response shapes that do not match domain models 1:1, place them inside `lib/models/dto.dart`.

#### Model Code Pattern (Freezed)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hiker.freezed.dart';
part 'hiker.g.dart';

@freezed
class Hiker with _$Hiker {
  const factory Hiker({
    required String id,
    required String firstName,
    required String lastName,
    required String identityNumber, // NIK or Passport
    required String phoneNumber,
    required String emergencyContactPhone,
    required String emergencyContactName,
    String? medicalNotes,
    String? userId,
  }) = _Hiker;

  factory Hiker.fromJson(Map<String, dynamic> json) => _$HikerFromJson(json);
}
```

### Rule C: Repository Pattern & Fake Data
Repositories act as the single source of truth for raw data fetching. 
- Always define a clean interface or concrete repository class.
- When API endpoints are not yet ready, implement a **mock/fake data delay** inside the repository rather than hardcoding static mock lists directly inside UI widgets.

#### Repository Code Pattern
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mountain.dart';

class MountainRepository {
  // TODO: Replace with Dio/Http client when Django Ninja endpoint is live
  Future<List<Mountain>> fetchMountains() async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate API latency
    return [
      Mountain(
        id: 'kelud-01',
        name: 'Gunung Kelud',
        location: 'Kediri, Jawa Timur',
        height: 1731,
        mainImageUrl: 'https://example.com/kelud.jpg',
        difficultyLevel: DifficultyLevel.easy,
        indonesianWeekdayPrice: 10000,
      ),
    ];
  }
}

final mountainRepositoryProvider = Provider<MountainRepository>((ref) {
  return MountainRepository();
});
```

### Rule D: State Management with Riverpod Generators
- **Do NOT use `ChangeNotifier`**, `StatefulWidget` for global state, or manual `setState()` for asynchronous remote data.
- Use `riverpod_annotation` (`@riverpod`) to generate clean `Notifier` and `AsyncNotifier` classes.

#### State Management Code Pattern
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/mountain.dart';
import '../../repositories/mountain_repository.dart';

part 'mountain_list_notifier.g.dart';

@riverpod
class MountainListNotifier extends _$MountainListNotifier {
  @override
  FutureOr<List<Mountain>> build() async {
    final repository = ref.watch(mountainRepositoryProvider);
    return repository.fetchMountains();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(mountainRepositoryProvider).fetchMountains());
  }
}
```

### Rule E: Static Helpers in Utils
If a helper function or utility is pure, deterministic, and does not hold internal state, make it a **static class or top-level function** in `lib/utils/`.

#### Utility Code Pattern
```dart
import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._(); // Private constructor to prevent instantiation

  static String toRupiah(num amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }
}
```

---

## 5. Special Instructions for AI Code Reviewers & Copilots

If you are an automated AI reviewer (e.g., CodeRabbit, GitHub Copilot, or automated PR reviewer):

1. **Language Requirement:** Write all code reviews, comments, and PR summaries in **Indonesian (Bahasa Indonesia)**, except for standard technical/code terms (e.g., *state management*, *provider*, *repository*, *widget tree*, *null safety*).
2. **Review Tone & Focus:**
   - Be constructive, precise, and concise. Avoid unnecessary preamble.
   - Point out architectural violations directly (e.g., placing raw network calls inside build methods, missing Freezed annotations, or modifying models in `lib/models/`).
3. **Checklist for PR Approval:**
   - [ ] No `ChangeNotifier` or obsolete state management introduced.
   - [ ] UI code is split into atomic components (no giant monolithic build files).
   - [ ] All models inside `lib/models/` remain immutable and leverage Freezed.
   - [ ] Colors match Tenir's design palette (`#1E2B22`, `#D7EDE0`, `#FF6B35`).
   - [ ] Code compiles cleanly with `flutter analyze`.