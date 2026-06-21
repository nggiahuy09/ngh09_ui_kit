# Kế hoạch xây dựng Flutter UI Kit — `ngh09_ui_kit`

> Mục tiêu: Một Flutter **package** (không phải app) đóng vai trò UI Kit / Design System,
> publish được lên **pub.dev**, dựa trên **Material 3 + design tokens riêng**,
> có catalog bằng **Widgetbook**, và được kiểm thử đầy đủ **Unit + Widget + Golden**.

---

## 0. Quyết định nền tảng (đã chốt)

| Hạng mục | Lựa chọn |
|---|---|
| Phân phối | Publish lên pub.dev (package thuần, không app) |
| Theming | Material 3 (`ThemeExtension`) + design tokens custom |
| Catalog | Widgetbook |
| Kiểm thử | Unit + Widget + Golden (alchemist) |

**Hệ quả kiến trúc:**
- Repo hiện tại là `flutter create` app mặc định → cần **chuyển thành package**: xoá `main.dart`,
  xoá thư mục platform không cần (`android/ios/linux/macos/windows/web`) khỏi package gốc
  (giữ lại trong thư mục `example/` và `widgetbook/`), bỏ `publish_to: 'none'`.
- Vì publish pub.dev: cần `CHANGELOG.md`, `LICENSE`, `example/`, doc comments `///`,
  versioning theo SemVer, đạt pub points cao (format, analyze, doc coverage).

---

## 1. Cấu trúc thư mục

```
ngh09_ui_kit/
├── lib/
│   ├── ngh09_ui_kit.dart            # Barrel export công khai (public API)
│   └── src/
│       ├── tokens/                  # Design tokens (giá trị thô, primitive)
│       │   ├── colors.dart          # Color palette gốc (primitive colors)
│       │   ├── spacing.dart         # 4/8pt scale: xs, sm, md, lg, xl...
│       │   ├── typography.dart      # Font sizes, weights, line-heights
│       │   ├── radii.dart           # Border radius scale
│       │   ├── elevation.dart       # Shadow / elevation tokens
│       │   ├── durations.dart       # Animation durations & curves
│       │   └── breakpoints.dart     # Responsive breakpoints
│       │
│       ├── theme/                   # Semantic layer + ThemeData
│       │   ├── app_colors.dart      # ThemeExtension: màu ngữ nghĩa (surface, onSurface, danger...)
│       │   ├── app_typography.dart  # ThemeExtension: text styles ngữ nghĩa
│       │   ├── app_spacing.dart     # ThemeExtension: spacing
│       │   ├── app_radii.dart       # ThemeExtension: radii
│       │   ├── app_theme.dart       # buildLightTheme() / buildDarkTheme() -> ThemeData
│       │   └── theme_extensions.dart# Helper: context.colors, context.spacing...
│       │
│       ├── foundations/             # Khối nền dùng lại nội bộ
│       │   ├── icons.dart           # AppIcons (icon set)
│       │   └── assets.dart          # Đường dẫn asset (nếu có)
│       │
│       ├── components/              # Các widget public, mỗi loại 1 folder
│       │   ├── buttons/
│       │   │   ├── app_button.dart
│       │   │   ├── app_icon_button.dart
│       │   │   └── button_variant.dart
│       │   ├── inputs/
│       │   │   ├── app_text_field.dart
│       │   │   ├── app_checkbox.dart
│       │   │   ├── app_radio.dart
│       │   │   ├── app_switch.dart
│       │   │   └── app_dropdown.dart
│       │   ├── feedback/
│       │   │   ├── app_snackbar.dart
│       │   │   ├── app_dialog.dart
│       │   │   ├── app_toast.dart
│       │   │   └── app_loading.dart
│       │   ├── display/
│       │   │   ├── app_card.dart
│       │   │   ├── app_badge.dart
│       │   │   ├── app_avatar.dart
│       │   │   ├── app_chip.dart
│       │   │   └── app_divider.dart
│       │   ├── navigation/
│       │   │   ├── app_app_bar.dart
│       │   │   ├── app_tab_bar.dart
│       │   │   └── app_bottom_nav.dart
│       │   └── layout/
│       │       ├── app_scaffold.dart
│       │       └── app_gap.dart       # Gap(Spacing.md) helper
│       │
│       └── utils/
│           ├── context_extensions.dart  # MediaQuery, theme shortcuts
│           └── responsive.dart          # Responsive builder theo breakpoints
│
├── example/                         # App demo tối thiểu (yêu cầu của pub.dev)
│   └── lib/main.dart
│
├── widgetbook/                      # App Widgetbook catalog (project riêng)
│   ├── lib/
│   │   ├── main.dart
│   │   └── use_cases/               # .usecase.dart cho mỗi component
│   └── pubspec.yaml                 # depend ngh09_ui_kit qua path: ../
│
├── test/
│   ├── tokens/                      # Unit test cho tokens/theme
│   ├── components/                  # Widget test cho từng component
│   └── flutter_test_config.dart     # Cấu hình alchemist (load font)
│
├── test/goldens/                    # Ảnh golden được sinh ra (.png)
│
├── .github/workflows/ci.yaml        # CI: format, analyze, test, golden
├── analysis_options.yaml            # Lint nghiêm (very_good_analysis)
├── CHANGELOG.md
├── LICENSE
├── README.md
└── pubspec.yaml
```

**Nguyên tắc kiến trúc 2 tầng token (rất quan trọng):**
- `tokens/` = **primitive** (giá trị thô, không mang ngữ nghĩa): `blue500 = Color(0xFF...)`.
- `theme/` = **semantic** (ánh xạ primitive → vai trò): `colorPrimary = blue500`, đổi theo light/dark.
- Component **chỉ** đọc từ semantic layer qua `context.colors`, **không bao giờ** hardcode primitive.
  → Đổi theme/brand chỉ sửa 1 chỗ.

---

## 2. Các thành phần cần implement (theo thứ tự ưu tiên)

### Phase A — Foundation (làm trước, mọi thứ phụ thuộc vào đây)
1. **Design tokens** (`tokens/`): color palette, spacing scale (4/8pt), typography scale,
   radii, elevation, durations.
2. **ThemeExtensions** (`theme/`): `AppColors`, `AppTypography`, `AppSpacing`, `AppRadii`.
3. **AppTheme**: `buildLightTheme()`, `buildDarkTheme()` trả `ThemeData` đã gắn extensions.
4. **Context extensions**: `context.colors`, `context.spacing`, `context.textStyles`.

### Phase B — Core components (dùng nhiều nhất)
5. **AppButton** (variants: filled / tonal / outlined / text; sizes: sm/md/lg; states:
   loading, disabled; leading/trailing icon).
6. **AppTextField** (label, hint, error, prefix/suffix, helper, obscure).
7. **AppCard**, **AppGap** (spacing helper).
8. **Typography widget** (`AppText` với style ngữ nghĩa: `displayLarge`, `bodyMedium`...).

### Phase C — Form & feedback
9. AppCheckbox, AppRadio, AppSwitch, AppDropdown.
10. AppDialog, AppSnackbar/Toast, AppLoading (spinner/skeleton).

### Phase D — Display & navigation
11. AppBadge, AppAvatar, AppChip, AppDivider.
12. AppAppBar, AppTabBar, AppBottomNav, AppScaffold.

> Mỗi component khi "xong" = code + doc comment `///` + use case Widgetbook + widget test + golden test.

---

## 3. Quy ước style & coding convention

- **Đặt tên:** mọi widget public prefix `App` (`AppButton`) để tránh xung đột với Material.
- **Variant/size dùng `enum`** + factory constructor, không truyền String.
- **Không hardcode** màu/spacing trong component → luôn `context.colors` / `context.spacing`.
- **API rõ ràng:** mọi public class/method có doc comment `///` (ảnh hưởng pub points).
- **Immutable:** widget `const` constructor khi có thể.
- **Lint:** dùng `very_good_analysis` (nghiêm hơn `flutter_lints`) trong `analysis_options.yaml`,
  bật `public_member_api_docs`.
- **Format:** `dart format .` bắt buộc, kiểm tra trong CI.

---

## 4. Chiến lược kiểm thử

| Loại | Công cụ | Test cái gì | Vị trí |
|---|---|---|---|
| Unit | `flutter_test` | Token values, theme mapping, logic của variant/size, responsive util | `test/tokens/`, `test/utils/` |
| Widget | `flutter_test` | Render đúng, tap/onChanged callback, trạng thái disabled/loading, semantics (a11y) | `test/components/` |
| Golden | **alchemist** | Snapshot UI mỗi component × variants × light/dark | `test/components/*_golden_test.dart` |

**Vì sao alchemist** (thay vì `golden_toolkit`): xử lý font & shadow ổn định trên CI,
phân tách rõ "CI goldens" (so khớp pixel chính xác) vs "platform goldens", ít flaky hơn.

**Cấu hình:**
- `test/flutter_test_config.dart`: gọi `AlchemistConfig` + load font thật (Roboto) để golden
  không bị box vuông; tắt golden so-khớp khi chạy local nếu cần.
- Golden chạy theo theme: tạo helper render component trong cả light & dark.
- CI chạy golden ở chế độ `--update-goldens` bị cấm; chỉ verify. Cập nhật golden là thao tác
  thủ công có review (`flutter test --update-goldens`).

**Mục tiêu coverage:** ≥ 80% line coverage (đo bằng `flutter test --coverage` + `lcov`).

---

## 5. Widgetbook catalog

- `widgetbook/` là **project Flutter riêng** depend `ngh09_ui_kit` qua `path: ../`.
- Mỗi component có 1+ **use case** (`@UseCase` annotation + `widgetbook_generator`, hoặc khai báo tay).
- **Addons** bật: `ThemeAddon` (light/dark dùng chính `buildLightTheme/buildDarkTheme`),
  `TextScaleAddon`, `DeviceFrameAddon`, `AlignmentAddon`.
- **Knobs** cho props chính (text, boolean disabled/loading, enum variant) để demo tương tác.
- Build web: `flutter build web` trong `widgetbook/` → deploy lên GitHub Pages/Netlify làm
  "living styleguide" cho team.

---

## 6. CI/CD (`.github/workflows/ci.yaml`)

Pipeline chạy mỗi PR:
1. `flutter pub get`
2. `dart format --set-exit-if-changed .` (fail nếu chưa format)
3. `flutter analyze --fatal-infos`
4. `flutter test --coverage`
5. Golden verify (nằm trong bước test) — fail nếu UI đổi ngoài ý muốn; upload diff khi fail.
6. (Tùy chọn) `dart pub publish --dry-run` để đảm bảo luôn publish được.
7. (Tùy chọn) Build & deploy Widgetbook web lên GitHub Pages.

Release: tag `vX.Y.Z` → workflow `dart pub publish` (dùng pub.dev automated publishing
qua GitHub OIDC, không cần token).

---

## 7. Các bước thực thi (checklist tuần tự)

**Bước 1 — Chuyển app → package** ✅ ĐÃ XONG (2026-06-21)
- [x] Xoá `lib/main.dart` + `test/widget_test.dart`, tạo `lib/ngh09_ui_kit.dart` (barrel).
- [x] Sửa `pubspec.yaml`: bỏ `publish_to: 'none'`, description thật, `version: 0.1.0`,
      repository/homepage/issue_tracker, `sdk: ^3.9.0`. Dev deps: `alchemist ^0.14.0`,
      `very_good_analysis ^10.0.0`. (Widgetbook để ở project con `widgetbook/`, không nằm trong
      dev_deps của package publish.)
- [x] Xoá thư mục platform khỏi root (`android/ios/linux/macos/windows/web`, `.iml`) +
      `git rm --cached` để git phản ánh đúng (nếu không `pub publish` vẫn đọc từ git).
- [x] Thêm `LICENSE` (MIT), `CHANGELOG.md`, `.gitignore`; cập nhật `README.md`,
      `analysis_options.yaml` (very_good_analysis + strict modes).
- [x] Tạo `example/` app demo runnable + foundation skeleton (tokens/theme/context) +
      smoke test `test/tokens/app_theme_test.dart`.
- [x] Kiểm chứng: `flutter analyze` sạch, `flutter test` pass 3/3, `dart format` sạch,
      `pub publish --dry-run` chỉ còn 1 warning lành tính (uncommitted changes).

> Ghi chú môi trường: dùng **fvm Flutter 3.35.6 / Dart 3.9.2** (`fvm use 3.35.6`) vì
> `very_good_analysis ^10` yêu cầu Dart ≥3.9.

**Bước 2 — Foundation (Phase A)**
- [ ] Implement `tokens/` → `theme/` (extensions + buildTheme) → `context_extensions`.
- [ ] Unit test tokens & theme mapping.

**Bước 3 — Hạ tầng test & catalog**
- [ ] `test/flutter_test_config.dart` (alchemist + font).
- [ ] Khởi tạo `widgetbook/` app + addons; viết use case đầu tiên cho 1 component mẫu.
- [ ] Viết 1 component mẫu (AppButton) end-to-end: code → doc → usecase → widget test → golden.
      Đây là **template** để nhân bản cho các component sau.

**Bước 4 — Build components (Phase B → C → D)**
- [ ] Lặp lại pattern của AppButton cho từng component theo thứ tự ưu tiên.

**Bước 5 — CI & publish**
- [ ] Thêm `.github/workflows/ci.yaml`.
- [ ] `dart pub publish --dry-run` sạch lỗi.
- [ ] Setup automated publishing trên pub.dev, release `v0.1.0`.

---

## 8. Dependencies dự kiến (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  # giữ tối thiểu — UI kit không nên kéo dependency nặng

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis: ^6.0.0
  alchemist: ^0.x          # golden testing
  widgetbook: ^3.x
  widgetbook_annotation: ^3.x
  widgetbook_generator: ^3.x
  build_runner: ^2.x
```
> Triết lý: **zero/minimal runtime dependency**. Mọi thứ phục vụ dev (test/catalog) để ở `dev_dependencies`
> hoặc trong project con (`widgetbook/`), không lọt vào dependency của package publish.

---

## 9. Định nghĩa "Done" cho mỗi component

Một component được coi là hoàn thành khi:
1. Code dùng semantic token, có variant/size bằng enum, hỗ trợ light/dark.
2. Có doc comment `///` cho class và mọi public member.
3. Có ≥1 use case trong Widgetbook (kèm knobs).
4. Có widget test (render + tương tác + a11y semantics).
5. Có golden test cho các variant chính ở cả light & dark.
6. `dart format`, `flutter analyze` sạch.
```
