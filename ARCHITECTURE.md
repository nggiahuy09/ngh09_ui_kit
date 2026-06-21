# Kiến trúc & Flow của `ngh09_ui_kit`

> Tài liệu giải thích tổng quan repo: các folder/module quan trọng, flow implement
> một component, và flow test. Dành cho người mới tham gia hoặc cần nắm nhanh cách
> kit vận hành. Roadmap component nằm ở [PLAN.md](PLAN.md).

---

## Tổng quan

Đây là một **Flutter package** (không phải app) đóng vai trò **UI Kit / Design System**
dựa trên **Material 3 + design tokens riêng**, publish được lên pub.dev, có catalog bằng
**Widgetbook** và kiểm thử **Unit + Widget + Golden**.

Trạng thái hiện tại: **Foundation đã xong + 1 component (`AppButton`)**.

---

## 1. Bản đồ folder / module

```
lib/
├── ngh09_ui_kit.dart          ← Barrel export: public API DUY NHẤT của package
└── src/                       ← Toàn bộ là private (consumer không import trực tiếp)
    ├── tokens/      (Tầng 1 — PRIMITIVE)   giá trị thô, không ngữ nghĩa
    ├── theme/       (Tầng 2 — SEMANTIC)    ánh xạ primitive → vai trò, đổi theo light/dark
    ├── components/  (Tầng 3 — WIDGET)      widget public, chỉ đọc từ semantic layer
    └── utils/                              context extensions + responsive helpers
```

Điểm cốt lõi của kiến trúc là **2 tầng token** — đây là "linh hồn" của cả kit.

### Tầng 1 — `tokens/` (primitive, giá trị thô)

Các `abstract final class` chứa hằng số `static const`, **không mang ý nghĩa**:

- `tokens/colors.dart` — palette `brand50→900`, `neutral0→900`, status ramps
  `success/warning/danger/info` (50/500/700).
- `tokens/spacing.dart` — thang 4pt: `xs=4, sm=8, md=16, lg=24…`
- `tokens/typography.dart` — font size/weight/line-height theo type scale M3.
- `tokens/radii.dart`, `tokens/elevation.dart`, `tokens/durations.dart`,
  `tokens/breakpoints.dart` — `mobile=600, tablet=1024, desktop=1440`.

> **Quy tắc vàng:** widget **KHÔNG BAO GIỜ** đọc trực tiếp `ColorTokens.brand500`.

### Tầng 2 — `theme/` (semantic, ánh xạ có ý nghĩa)

Mỗi file là một `ThemeExtension<T>` với `copyWith` + `lerp`:

- `theme/app_colors.dart` — vai trò ngữ nghĩa (`primary`, `surface`, `onSurface`,
  `outline`, `danger`…). Có 2 preset `.light()`/`.dark()` map primitive khác nhau,
  và `toColorScheme()` để chiếu sang `ColorScheme` của Material.
- `theme/app_typography.dart` — 15 text style ngữ nghĩa + `toTextTheme()`.
- `theme/app_spacing.dart`, `theme/app_radii.dart` — (radii còn có getter
  `borderRadiusMd` tiện dùng).
- `theme/app_theme.dart` — **điểm lắp ráp**: `AppTheme.light()/dark()` build
  `ThemeData` M3, chiếu semantic colors→`ColorScheme`, typography→`TextTheme`, rồi
  gắn 4 extension vào. Nhận tham số `colors`/`typography` tùy biến để **re-brand**.

### `utils/`

- `utils/context_extensions.dart` — đường tắt `context.colors`, `context.spacing`,
  `context.radii`, `context.textStyles`, `context.isDarkMode` (thay cho
  `Theme.of(context).extension<...>()!` dài dòng) + helpers MediaQuery
  (`isMobile/isTablet/isDesktop`).
- `utils/responsive.dart` — `enum ScreenType`,
  `context.responsiveValue(mobile:…, tablet:…, desktop:…)` (có fallback xuống
  breakpoint nhỏ hơn), và widget `ResponsiveBuilder`.

### Tầng 3 — `components/`

- `components/buttons/button_variant.dart` — `enum ButtonVariant`
  (filled/tonal/outlined/text) + `enum ButtonSize` (small/medium/large).
- `components/buttons/app_button.dart` — `StatelessWidget`, đọc **100% từ
  `context.*`**, không hardcode. Có default + 4 named constructor, `leading/trailing`,
  `isLoading`/`disabled` (`onPressed == null`)/`expanded`. Loading giữ nguyên label
  để layout không nhảy. Tận dụng semantics có sẵn của
  `FilledButton/OutlinedButton/TextButton`.

### Project con (không thuộc package publish)

- `example/` — app demo runnable (yêu cầu pub.dev).
- `widgetbook/` — catalog Flutter riêng, depend ngược qua `path: ../`, **không lọt
  vào dependency** của package.

---

## 2. Flow IMPLEMENT một component (theo đúng mẫu `AppButton`)

Luồng dữ liệu khi chạy:

```
primitive token → semantic extension → AppTheme gắn vào ThemeData
  → MaterialApp(theme:) → widget đọc qua context.colors/...
```

Khi viết component mới, lặp lại đúng 6 bước (định nghĩa "Done" ở mục 9 của PLAN):

1. **Enum variant/size** trong file riêng (`*_variant.dart`) — không dùng String.
2. **Widget** trong `components/<nhóm>/app_xxx.dart` — `StatelessWidget`, `const`
   constructor, named constructor cho từng variant; mọi màu/spacing/radius lấy từ
   `context.*`; dùng `switch` expression để map variant→token (xem
   `_foregroundColor`/`_backgroundColor` trong `AppButton`).
3. **Doc comment `///`** cho class + mọi public member (bắt buộc cho pub points —
   lint `public_member_api_docs`).
4. **Export** qua barrel `lib/ngh09_ui_kit.dart`.
5. **Use case Widgetbook** trong `widgetbook/lib/use_cases/` (Playground + Variants +
   Sizes), rồi đăng ký vào `widgetbook/lib/main.dart`.
6. **Test** (xem mục 3).

---

## 3. Flow TEST (3 tầng)

| Tầng | Công cụ | Test gì | File |
|---|---|---|---|
| **Unit** | `flutter_test` | giá trị token, mapping theme→`ColorScheme`/`TextTheme`, `copyWith`/`lerp`, `ScreenType`, context extensions | `test/tokens/app_theme_test.dart` |
| **Widget** | `flutter_test` | render đúng, tap callback, disabled/loading, ẩn icon khi loading, **a11y semantics** (`matchesSemantics`), named-ctor→variant, expanded width | `test/components/buttons/app_button_test.dart` |
| **Golden** | **alchemist** | snapshot UI mỗi variant × light/dark, sizes, states | `test/components/buttons/app_button_golden_test.dart` + ảnh trong `goldens/ci/` |

Cơ chế quan trọng:

- **`test/flutter_test_config.dart`** — Flutter tự chạy file này trước mọi test. Nó
  bọc `AlchemistConfig.runWithConfig` và **tắt platform goldens**, chỉ giữ **CI
  goldens** (pixel-exact, ổn định mọi máy → ít flaky). Alchemist tự load font thật
  nên chữ không bị box vuông.
- Pattern test luôn có helper `_wrap`/`_themed` bọc widget trong
  `AppTheme.light()/dark()` để `context.*` resolve được.
- Golden cho `loading` dùng `pumpBeforeTest: pumpOnce` vì spinner quay vô hạn →
  `pumpAndSettle` sẽ treo.
- Cập nhật golden là thao tác thủ công có review: `flutter test --update-goldens`
  (CI chỉ verify, cấm update).

**Lệnh chạy thực tế (dùng fvm Flutter 3.35.6):**

```bash
dart format .
flutter analyze --fatal-infos
flutter test                       # gồm cả golden compare
flutter test --update-goldens      # khi cố ý đổi UI
```

---

## Tóm lại — mental model

> **Token thô → gán ý nghĩa (semantic) → `AppTheme` đóng gói vào `ThemeData` →
> widget chỉ "đọc" qua `context.*`.** Đổi brand/theme chỉ sửa **một chỗ** (semantic
> layer), mọi component tự đổi theo. Mỗi component "xong" khi đủ: code token-driven +
> doc `///` + Widgetbook use case + widget test (gồm a11y) + golden test light/dark.
