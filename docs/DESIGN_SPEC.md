# Godam UI/UX design specification

## Evidence and confidence

- **Source:** [Godam UI/UX Figma page](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=318-177), file key `FjVF7z4opM9ZCHGsTVMFmU`, page node `318:177`.
- The supplied node is a **PAGE**, not a single screen. Its overview screenshot and immediate child hierarchy were retrieved. Child frames were queried individually with `get_design_context` where available.
- **Verified** means returned by Figma frame hierarchy or design-context metadata/code. **Visual estimate** means observed in the overview or inferred from a static render. **Unknown** means unavailable or not established by the design evidence.
- Figma returned context for 14 of the 16 listed children. Context for `3_Onboard` timed out and a retry, plus `07 New_item`, hit the Figma MCP Starter-plan call limit. Prototype/component metadata inspection was also blocked. The page overview was visually reviewed; individual frame screenshot comparison remains outstanding.
- Figma context contains temporary asset URLs. They are not durable source references and must not be used as runtime Flutter asset paths.

## Screen inventory

Every screen frame below is 393 × 852 except `02 Home` at 393 × 1039. The Loading component set is 213 × 140. These are Figma frame dimensions; whether they correspond to Flutter logical pixels or represent the supported device size is unknown.

### Entry screens

- [01 Splash Screen — `318:200`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=318-200). App name/tagline, decorative pattern and a Loading progress component. Context returned.

#### Splash implementation reference (`318:200`)

- **Verified from the previously retrieved frame context:** frame is 393 × 852; background `#FBFAF6`; the wordmark `گدام` is Kalameh SemiBold 32 px in `#1C1A15`; subtitle `مدیریت هوشمند گدام(انبار) و دکان` is Kalameh Light 12 px in the same color, with a 4 px text gap. The centered text group begins at y=402.
- **Verified asset references:** `pattern 1` node `339:1767` (329.091 × 333.934), `Ellipse3` node `341:1927` (276 × 276), and Loading component set node `333:432`; its Default variant is node `333:428` (173 × 4) at x-centered, y=465. The other variants are `333:433`, `333:436`, `333:445`, `333:448`.
- **Downloaded exports in this repository:** [`pattern-1.svg`](../assets/figma/splash/pattern-1.svg), [`ellipse-3.svg`](../assets/figma/splash/ellipse-3.svg), [`loading-default.svg`](../assets/figma/splash/loading-default.svg). The exports came from temporary Figma MCP asset URLs and are local implementation inputs, not durable Figma links.
- **Available implementation fonts:** the repository now contains the Kalameh family. Flutter registers `Kalameh-Light.ttf` at weight 300 and `Kalameh-SemiBold.ttf` at weight 600 from `assets/fonts/Kalameh/01- Standard Fonts/TTF/`, matching the Splash subtitle and wordmark styles. The repository also contains the font license documents; confirm project distribution rights before shipping the app.
- **Loading implementation:** the original Figma Loading component set is documented above, but Splash uses `AppleLinearProgress` from `lib/widgets/apple_linear_progress.dart` rather than its Default SVG variant. The bar occupies a centered 173 × 6 slot, uses the app theme primary, advances once to full, and remains full until supplied startup work completes. Without startup work, it advances automatically.
- **Screenshot verification:** the exact-frame screenshot endpoint could not be queried again during implementation because of the Figma MCP Starter-plan request limit. The screen is positioned from the prior frame context and has not been runtime-compared against an exact frame screenshot.
- **Unknown:** Splash destination/navigation and system-bar safe-area behavior are not established by the retrieved frame context. The custom loading animation and optional pending-future behavior follow the user's implementation instruction, not a verified prototype interaction.
- [1_Onboard — `333:458`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=333-458). Introductory warehouse/sales message, illustration and arrow controls. Context returned.

#### Local SVG implementation reference: `1_Onboard.svg`

- **Source:** [`assets/ScreenShots/First Time Once Appear/1_Onboard.svg`](../assets/ScreenShots/First%20Time%20Once%20Appear/1_Onboard.svg), the local screen supplied for implementation. Figma MCP was not used.
- **Verified from SVG source:** 393 × 852 canvas, `viewBox="0 0 393 852"`; background `#FBFAF6`; teal header `#008081` from y=50 to y=336 with a curved lower edge. No external images, linked files, stylesheets, or `<text>` nodes are referenced; copy and status-bar glyphs are vector paths.
- **Verified geometry/colors:** title outline bounds x=98.47..295.75, y=178.32..197.24; description outline bounds x=116.36..282.37, y=215.44..267.06, both white. Top chevron outline bounds x=359..366.1, y=108.08..123.92 with `#99D6D6` at 70% opacity. Illustration consists of local vector paths bounded x=111..283, y=438.15..654.77, using `#008081`, `#004D4D`, and white. Bottom control is centered at (197,775), with a 40 px outer circle, a 2 px `#99D6D6` stroke, and a teal inner circle.
- **Visually verified:** rendered locally with installed Chrome headless to a temporary PNG outside the repository. The image shows a right-to-left title, three centered description lines, a shop illustration, a top-right chevron, and a bottom circular left chevron. The status icons and bottom home indicator in the export are platform chrome; Flutter uses system overlays instead of drawing those glyphs into the UI.
- **Flutter implementation:** all three onboarding illustrations use the supplied individual assets: [`f_onbrd_img.svg`](../assets/ScreenShots/illustrations/f_onbrd_img.svg) (172 × 217), [`s_onbrd_img.svg`](../assets/ScreenShots/illustrations/s_onbrd_img.svg) (172 × 181), and [`t_onbrd_img.svg`](../assets/ScreenShots/illustrations/t_onbrd_img.svg) (170 × 193). A responsive `PageView` lays out copy and illustrations within `SafeArea` and scrolls when vertical space is short. `OnboardingFrameBackground` paints the whole teal/cream frame and the moving boundary behind foreground content for all three pages, per the user's latest direction. No full-screen frame is cropped to obtain artwork.
- **Visual estimates:** outlined text does not retain font metadata. Slide one title/body styles remain estimates (Kalameh SemiBold about 20 px and Light about 12 px at the reference viewport). Slides two and three copy was transcribed from locally rendered previews; the exact font metadata remains unknown.
- **Interaction behavior:** this Flutter implementation maps the top-right control on slide one to Skip, on slides two and three to Back, the lower control to Next, and the final check to registration. Horizontal swiping changes pages. These callbacks were added to satisfy the requested flow; no Figma prototype transition evidence was retrieved. The local design contains no visible page indicators, so none are added.
- **Registration implementation:** `/register` uses native Flutter form widgets arranged from this local visual reference. The full-frame export is not embedded as the active screen; its geometry and copy inform the implementation, and the dedicated illustration is reused.
- **Registration local reference detail:** the 393 × 852 `Register.svg` was rendered locally after the Figma MCP request reached the Starter-plan limit. The SVG exposes two 328 × 52 fields at x=33 (y=433 and y=497), a 328 × 48 teal button at x=33/y=573, and a terms checkbox at x=268/y≈639. The visible copy reads “خوش آمدید”, a short prompt to enter the user and business names, “نام کاربری”, “نام دکان/ کسب و کار”, “شروع”, and consent to Godam’s terms. These labels are visually transcribed from outlined SVG text, not Figma text-layer metadata. The related [`fo_onbrd_img.svg`](../assets/ScreenShots/illustrations/fo_onbrd_img.svg) is 131 × 135 and is used as a responsive illustration in the native Flutter registration form. Its actual terms text and registration destination/service are unknown.
- **Related local SVGs:** `2_Onboard.svg`, `3_Onboard.svg`, and `Register.svg` are 393 × 852 exports. `2_Onboard.svg` and `3_Onboard.svg` were locally rendered to inspect their copy and visual states; their dedicated illustration assets are used in Flutter.
- [2_Onboard — `344:1939`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=344-1939). Profit/expense explanation, illustration and onboarding controls. Context returned.
- [3_Onboard — `344:2011`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=344-2011). Third onboarding screen visible in the overview. Detailed copy, assets and layout need reinspection.
- [Register — `345:2117`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=345-2117). Welcome and registration screen with username/business-name fields, terms checkbox and start button. Context returned.

### Main app

- [02 Home — `354:2981`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=354-2981). Dashboard with greeting/date, sales/expense/profit totals, best-selling product charts and recent activity. Context returned.
- [03 Inventory — `365:3500`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=365-3500). Search/filter controls, categories and stock rows, low-stock/value summaries and product details. Context returned.
- [04 Expense — `365:3711`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=365-3711). Period selector, expense total/category summaries and expense records. Context returned.
- [05 Sell — `365:3851`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=365-3851). Period selector, sales total, cash/credit summaries and sale records. Context returned.
- [06 Menu — `498:334`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=498-334). Home content with a visible menu overlay, profile area and menu items. Context returned; prototype open/close behavior unknown.
- [07 New_item — `656:490`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=656-490). Item-entry form visible in page overview. Detailed form fields, asset mapping and behavior need reinspection.

### Empty states

- [01 Home_empty — `531:229`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=531-229). Welcome prompt to add products. Context returned.
- [02 Inventory_empty — `531:616`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=531-616). Empty inventory illustration and add-item CTA. Context returned.
- [03 Expense_empty — `531:396`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=531-396). Empty expense illustration and register-expense CTA. Context returned on retry.
- [04 Sell_empty — `531:946`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=531-946). Empty sales illustration and register-sale CTA. Context returned.

#### Empty-state implementation reference details

- **Verified from local full-frame SVGs and visual rendering:** all four frames are 393 × 852, with a warm off-white background, white top header, distinct supplied illustration, Persian heading/subheading, teal rounded CTA, and a bottom four-tab pill. The durable frame references are the node IDs above; local full-frame inputs are `assets/ScreenShots/Empty States/01 Home_empty.svg` through `04 Sell_empty.svg`.
- **Verified copy and local art mapping:** Home (`531:229`) uses `h_empty_img.svg`, “خوش آمدید به گدام”, “برای شروع کار لطفا اجناس تان را وارد برنامه کنید”, and “افزودن جنس”. Inventory (`531:616`) uses `i_empty_img.svg`, “گدام شما خالیه!”, “اجناس تان را اینجا وارد کنید”, and “افزودن جنس”. Expenses (`531:396`) uses `e_empty_img.svg`, “هنوز مصرفی ثبت نشده”, “هزینه های تان را ثبت کنید تا ضرر نکنید!”, and “ثبت مصارف”. Sales (`531:946`) uses `s_empty_img.svg`, “چیزی فروخته نشده!”, “همین حالا اولین فروش تان را ثبت کنید.”, and “ثبت فروش”.
- **Verified navigation appearance:** labels run right-to-left as خانه (Home), انبار (Inventory), مصارف (Expenses), فروش (Sales); each frame highlights its corresponding tab. The outer pill is approximately 252 × 56 with `#E6F5F5` fill and `#99D6D6` border; the active segment is approximately 64 × 48 with `#99D6D6` fill. The header and CTA colors/radii follow the design tokens above.
- **Visual estimates:** body content begins around y=254 in the 393 × 852 references; the illustration slots and vertical gaps are responsive approximations in Flutter, and Kalameh 18/13/15 px styles were visually matched to the available local font. A temporary Flutter test render was visually checked against the supplied local Home SVG. Emulator/device comparison was not performed; system safe-area insets can shift the bottom navigation relative to a bare test viewport.
- **Unknown:** prototype transitions, CTA destinations, menu/notification behavior, tab state persistence beyond the current in-memory shell, and whether populated tab screens should replace or follow these empty states. CTA controls retain the visual reference style but remain disabled until destinations are specified; the header menu and notification marks are decorative.

### Component set

- [Loading — `333:432`](https://www.figma.com/design/FjVF7z4opM9ZCHGsTVMFmU/Godam-UI-v2.0?node-id=333-432). Component set, 213 × 140, with five variants: `Default` (`333:428`), `Variant2` (`333:433`), `Variant3` (`333:436`), `Variant4` (`333:445`), and `Variant5` (`333:448`). Context returned.

## Design system

### Verified color values from frame-context metadata

- Background `#FBFAF6`; Surface `#FFFFFF`.
- Primary `#008081`; Primary Hover `#006667`; Primary Active `#004D4D`.
- Primary Muted `#99D6D6`; Primary Subtle `#E6F5F5`; Border `#E2E0D8`.
- Text Primary `#1C1A15`; M3 on-surface `#1D1B20`; Text Secondary `#645F50`; Text Muted `#A8A499`.
- Success `#1C8B5C`; Warning `#B07A1E`; Info `#2E75B6`; Error `#B23D3D`; Neutral `#353535`.

These names/values appeared in returned context metadata. Variable bindings/collections were not inspected; do not assume they are all Figma variables.

### Verified typography references

- Main typeface: Kalameh. Named styles found: H2 Medium 24 px; H3 Regular 20 px; H4 Regular 17 px; Body Large Light 17 px; Body Light 15 px; Body Small Light 13 px; Caption Light 12 px. The Splash title uses Kalameh SemiBold 32 px. Compact labels/navigation use 8–16 px sizes in generated context.
- Other family references: Leila Bold (headings) and Estedad-VF Regular (registration terms text).
- Named style metadata reports line height 100% and letter spacing 0. Font files, variable font axes, licensing and complete glyph coverage are unknown.

### Geometry and layout

- **Verified Register dimensions:** inputs 328 × 52 px, radius 16, fill `#E6F5F5`, border `#99D6D6`; primary button 328 × 48 px, radius 16, fill `#008081`.
- **Context geometry for Inventory navigation:** outer pill 252 × 56 px, radius 32; active area 64 × 48 px, radius 24.
- **Visual/context estimates:** repeated radii include 4, 8, 12, 16, 24 and 32 px. No canonical spacing scale was returned; code includes fixed frame positions and varied gaps. No explicit shadows appeared in inspected frame code.
- Home's 1039 px frame exceeds the other screen frames' 852 px height. Whether this represents a scrollable screen or a taller design canvas is unknown.

## RTL, language and formatting

- **Verified:** Arabic-script copy is laid out right-to-left; generated frame code marks text `dir="auto"` and uses right-aligned text in form/content areas. The four tab labels are Home, Inventory, Expenses and Sales, visually ordered right-to-left. Design includes the Afghani symbol `؋` and a date using the month name “سنبله”.
- **Unknown:** exact locale designation (Dari/Persian), numeral system preferences, calendar/date formatting rules, mixed LTR/RTL behavior, and whether all content must be localized.
- Do not assume every icon should be mirrored; directional icons need per-asset review.

## Assets, iconography and fonts

Figma contexts expose temporary SVG asset endpoints and layer names. The durable references currently available are the frame IDs above; exact layer IDs for every asset were not captured. Export assets from Figma during implementation and map each export back to its frame/layer and rendered slot.

- Splash `318:200`: decorative `pattern 1`, ellipse artwork, wordmark text, Loading vector variants.
- Onboarding `333:458`, `344:1939`, `344:2011`: per-screen hero illustration, decorative vector artwork and arrow controls; third-frame mapping unknown.
- Registration `345:2117`: illustration/group asset.
- Home `354:2981`: circular chart segments/indicators; Vuesax home, archive, receipt/ticket, notification and menu icons.
- Inventory `365:3500`: filter/search, category/product, receipt and bottom-navigation icons.
- Expense `365:3711`: empty-wallet and shop/flash/group/document category icons, receipt and navigation icons.
- Sell `365:3851`: money/payment, sales/category and navigation icons.
- Empty states `531:229`, `531:616`, `531:396`, `531:946`: distinct illustrations plus add/register controls.
- Menu `498:334`: profile, lock, calendar, send/feedback, support/community and close icons.
- New Item `656:490`: exact assets unknown pending frame context.
- Font checklist: Kalameh Light and SemiBold TTFs are bundled and registered for Flutter. Leila Bold and Estedad-VF were referenced in Figma metadata but are not confirmed in the project assets; obtain them only if a screen implementation needs them. Confirm redistribution rights for Kalameh before release.

The generated context includes Code Connect references to Material 3 Design Kit `Building Blocks/status-bar` and `Building Blocks/navigation`. Those Figma library components are not present in this Flutter repository. Other repeated patterns (buttons, fields, bottom nav, filters, cards, empty states) are candidates for Flutter reuse, but their Figma component types/variants are unverified.

## Visible controls and prototype behavior

Visible controls include onboarding arrows, registration fields/checkbox/start button, notification/menu controls, four tab items, period filters, inventory search/filter, and empty-state add/register CTAs. This verifies visual affordances only.

**No prototype transition is verified.** Figma prototype reactions could not be retrieved after the MCP call limit. Screen sequence and CTA destinations must not be inferred from numbering or labels. Menu open/close, tab state preservation, onboarding completion, form validation/save, and data-driven behavior remain unknown.

## Responsive assumptions

- Verified design frame width is 393 px. Most frames are 393 × 852; Home is 393 × 1039.
- Figma does not specify breakpoints or tablet behavior. Current Flutter entry/onboarding layouts use available constraints and `SafeArea`; onboarding uses a vertical scroll view for short viewports. Widget coverage targets compact 320 × 568 and tall 432 × 932 logical-pixel viewports. Actual emulator comparison at two device sizes remains pending.
- The frames contain Material 3 status/navigation Code Connect references on several screens. Confirm how Android system status and gesture/navigation bars should interact with Flutter safe areas.

## Reinspection checklist

1. Retrieve detailed context and screenshot for `3_Onboard` (`344:2011`) and `07 New_item` (`656:490`).
2. Retrieve prototype reactions for page `318:177`; record source node, trigger, destination and transition.
3. Inspect the Loading set plus status bar, navigation, checkbox and repeated controls for actual component/variant metadata.
4. Inspect variable collections/styles and export a durable asset/font manifest with original layer IDs.
5. Confirm locale, text formatting, breakpoints, scroll behavior and target Android viewport.
