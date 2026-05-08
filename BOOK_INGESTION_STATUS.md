# Fortune Teller Deep Ingestion Status

Goal: maximize depth from 20 core books/sources across Horoscope, Zi Wei/Tu Vi, and Yi Jing/Kinh Dich.

Rule: do not claim completion until each source has chapter-level notes, term glossary, and cross-source consistency checks.

## Completion standard per source

A source is marked `COMPLETE` only when all are done:
1. Full structure mapped (parts/chapters/sections)
2. Core concepts extracted with original terms
3. English translation layer written (for Chinese originals)
4. Practical interpretation rules captured
5. Contradictions vs other sources documented
6. Confidence rating assigned (`High`, `Medium`, `Low`)

## Source list and current status

### Horoscope / Western astrology
1. Ptolemy - Tetrabiblos — `IN PROGRESS (BATCH_06: Book I chapter-level doctrine (philosophical foundations, planetary natures, sign classifications, aspects); Book II chapter-level (mundane, eclipses, climates); Book III–IV deepened; all 4 books chapter-mapped)`
2. William Lilly - Christian Astrology — `IN PROGRESS (BATCH_06: Book I fundamentals (dignities table, fortitudes/debilities, radicality rules); Book II complete horary question catalog by 12 houses; Book III natal techniques (rectification, hyleg, directions, profections, transits); full TOC mapped)`
3. Sakoian/Acker - The Astrologer's Handbook — `IN PROGRESS (BATCH_06: two-part structure mapped (Ch1–8 Basic, Ch9–16 Aspects); aspect interpretation system described at chapter level)`
4. Alan Oken - Complete Astrology — `IN PROGRESS (BATCH_06: three-book progressive arc mapped (As Above So Below → The Horoscope → Evolution and Revolution); natal→progression→transit integration model identified; compilation omissions noted)`
5. Llewellyn George - A to Z Horoscope Maker/Interpreter — `IN PROGRESS (BATCH_06: reference structure mapped; key content areas (casting, progressed chart, delineations, rectification, stimuli); A–Z lookup system described)`
6. Ada Aubin/June Rifkin - Complete Book of Astrology — `IN PROGRESS (BATCH_06: workbook structure mapped; content coverage (sun signs, ascendants, planets, houses, aspects, transits); worksheet-based learning format identified)`

### Zi Wei / Tu Vi / Mingli
7. 王亭之《中州派紫微斗数深造讲义》— `IN PROGRESS (BATCH_07: 十四正曜 upper-section star-nature rules extracted; first 2 of 60 star-configurations (紫微贪狼卯酉, 巨门辰戌) analyzed with 十二宫流转 method; Zhongzhou school's 本质定性→星曜互涉→四化影响→逐宫流转 methodology documented; 紫微/天机/太阳/武曲/天同/廉贞 specific rules with original Chinese + English)`
8. 陆斌兆《紫微斗数讲义》— `IN PROGRESS (BATCH_07: full 14-star grid with original Chinese character descriptions; palace-by-palace rules for first 6 stars from 命宫-父母宫 drill pattern; Wang Tingzhi's commentary layer documented; 星曜制化关系 (mutual-control) principles extracted; Zhongzhou School philosophical position quoted)`
9. 《紫微斗数全书》(common traditional editions) — `IN PROGRESS (BATCH_06: full chapter structure mapped; 太微赋/形性赋/星垣论/斗数准绳/安命身例/安十二宫例/格局 + quote-backed extraction with English translation)`
10. 万民英《三命通会》— `IN PROGRESS (BATCH_07: 卷二 complete (论天干阴阳生死 — all 10 stems with cosmic descriptions; 论地支 — 12 branches with landscape metaphors; 十干分配天文 + 十二支分配地理; 论十干合 — 5 combination types with character typology; 论支元六合/三合; 论将星华盖/论咸池); 卷三 chapter structure mapped (论十干禄, 论金舆, 论驿马, 论天乙贵人, etc.) + key sections identified)`
11. 徐升《渊海子平》— `IN PROGRESS (BATCH_07: full chapter-level upgrade — 论日为主 framework with anti-mechanical doctrine; 干支暗藏 methodology (地支藏遁歌 + 节气管藏); complete 十神 system (正官/偏官/正财/偏财/印绶/食神/伤官/倒食/劫财/阳刃) with dedicated chapters; special pattern catalog (飞天禄马, 倒冲格, 井栏叉, 六乙鼠贵, 壬骑龙背) with anti-proliferation critique; 论疾病 (organ-stem correspondence + five-phase illness methodology); 论性情 (ten-god character types); 论大运 (交运接木, 转角接木 doctrine); 论太岁; all quote-backed with original Chinese + English)`
12. 沈孝瞻《子平真诠》— `IN PROGRESS (BATCH_05: 用神章群(8-12) quote-backed; 成败救应/变化/纯杂 deepened)`
13. 《滴天髓》(任铁樵阐微) — `IN PROGRESS (BATCH_06: full 34+28 chapter map; 天道/地道/人道/知命/理气/配合/体用/源流/通关/坎离/众寡 quote-backed with English translation; anti-mechanical stance deepened; 天覆地载 + 征验 methodology documented)`
14. 《穷通宝鉴》— `IN PROGRESS (BATCH_06: full 10-stem × 12-month template mapped; 五行总论 + 论甲→论癸 seasonal rules with original Chinese quotes + English translation; 调候 categorical logic systematized)`

### Yi Jing / Kinh Dich
15. 《周易》经文(通行本) — `IN PROGRESS (BATCH_08: 13 hexagrams line-extracted with Chinese+English (added 比, 小畜, 履, 泰, 否, 同人); 大象/小象 distinction applied to new hexagrams; 51 hexagrams remain at structural level)`
16. 王弼《周易注》— `IN PROGRESS (BATCH_08: 言-象-意 framework deepened with specific hexagram examples — 乾卦 line-progression phenomenology, 坤卦牝马 philosophy, 复卦天地之心 = 寂然至无, 临卦卦主 analysis; 卦主 system fully described; all with original Chinese + English)`
17. 程颐《周易程氏传》— `IN PROGRESS (BATCH_06: 体用一源/显微无间 framework quote-backed; seven-fold 成卦 typology extracted; 尽天理 stance + 随时取义 method systematized; 四书-易学 integration documented)`
18. 朱熹《周易本义》— `IN PROGRESS (BATCH_06: 爻位 analysis rules extracted from primary text; 象数/义理 integration demonstrated; 十翼 deployment catalogued; 卜筮-recovery thesis quoted; full-text notation parsed)`
19. 马王堆帛书《周易》— `IN PROGRESS (BATCH_06: 64-hexagram variant table with 6 systematic orthographic patterns; three-stream transmission model proposed; key doctrinal variants (川/坤, 婦/否, 克吉/中吉) highlighted)`
20. 战国竹简《周易》(fragment witnesses) — `IN PROGRESS (BATCH_06: merged with 帛书 comparative; pre-bifurcation state documented; Chu-region orthographic layer noted)`

## Working constraints

- "Absolute accuracy" is treated as an aspiration, not a claim.
- When editions disagree, all variants are preserved and annotated.
- Paywalled/copyrighted full texts may require approved copies to reach true full-ingestion depth.

## Current milestone

Milestone 1: establish canonical terms and interpretation spine across Zi Wei + Yi Jing originals first, then map Western parallels.

## Progress log

- `BATCH_01`: foundational structure/doctrine mapping started.
- `BATCH_02`: Chinese classics expansion (`三命通会`, `渊海子平`, `子平真诠`, `滴天髓`, `穷通宝鉴`, `程颐`, `朱熹`, manuscript witnesses).
- `BATCH_03`: remaining Western core first-pass mapping (books 3-6).
- `BATCH_04`: quote-backed extraction added (Chinese -> English evidence notes).
- `BATCH_05`: deepened priority sequence (`王亭之`, `陆斌兆`, `三命通会`, `子平真诠`) plus deeper `Tetrabiblos` Book III/IV and `Christian Astrology` Book II/III.
- `BATCH_06`: Yi Jing deep ingestion — `《周易》经文` (7 hexagrams line-extracted with Chinese+English, 大象/小象 distinction), `程颐` (体用一源, 尽天理, seven-fold 成卦 typology, 随时取义), `朱熹` (爻位 rules, 象数/义理 integration, 十翼 deployment), `马王堆帛书+竹简` (64-hexagram variant table, 6 orthographic patterns, 3-stream transmission model).
- `BATCH_06`: Western astrology deep ingestion: `Tetrabiblos` Books I–II chapter-level doctrine (philosophical foundations, planetary humors, sign classifications, eclipse doctrine, clime-based ethnic traits); `Christian Astrology` full TOC mapped with Book I fundamentals (dignities/fortitudes tables, radicality), Book II complete horary question catalog, Book III natal techniques (rectification, hyleg, directions, profections, transits); `Sakoian/Acker` two-part structure (Basic Ch1–8 + Aspects Ch9–16); `Alan Oken` three-book progressive arc (natal→progression→transit integration); `Llewellyn George` A–Z reference structure; `Aubin/Rifkin` workbook structure.
- `BATCH_06`: Zi Wei/Mingli deep ingestion — `《紫微斗数全书》` (full chapter structure; 太微赋/形性赋/星垣论/斗数准绳/安命身例/安十二宫例/格局 with quote-backed + English translation), `《滴天髓阐微》` (full 34+28 chapter map; 天道/地道/人道/知命/理气/配合/体用/源流/通关/坎离/众寡 with original quotes + English translation; 天覆地载 + 征验 methodology documented), `《穷通宝鉴》` (full 10-stem × 12-month template mapped; 五行总论 + 论甲→论癸 seasonal rules with original quotes + English translation; 调候 categorical logic systematized).
- `BATCH_07`: Zi Wei/Mingli gap-fill — `《渊海子平》` chapter-level upgrade (论日为主 + 干支暗藏 + full 十神 system + special pattern catalog (飞天禄马/倒冲格/井栏叉/六乙鼠贵/壬骑龙背) + 论疾病/性情/大运, all quote-backed); `《三命通会》` 卷二 complete (天干阴阳生死 + 地支 + 十干分配天文 + 十二支分配地理 + 十干合 + 支元六合/三合 + 将星华盖/咸池) + 卷三 chapter map (十干禄, 驿马, etc.); `王亭之` 深造讲义十四正曜 upper-section (紫微贪狼/巨门辰戌 full analysis, star-nature rules for 紫微/天机/太阳/武曲/天同/廉贞 with Zhongzhou methodology); `陆斌兆` 讲义 full 14-star grid with original quotes, palace rules, Wang Tingzhi commentary, 星曜制化 principles.
- `BATCH_08`: Yi Jing synthesis — `王弼《周易注》` deepened from framework to specific hexagram examples (乾卦 line-progression phenomenology, 坤卦牝马 philosophy, 复卦天地之心 = 寂然至无, 临卦卦主 analysis, all with original Chinese + English + Wang Bi's distinctive interpretive moves); `《周易》经文` expanded from 7 to 13 hexagrams (added 比, 小畜, 履, 泰, 否, 同人 with full line-text + English translation); **Yi Jing three-school contradiction matrix** (王弼 vs 程颐 vs 朱熹 on: foundational stance, 复卦天地之心 interpretation, 坤卦/牝马, reading method); **Zi Wei four-school taxonomy + contradiction matrix** (中州派/三合派/飞星派/透派 with specific methodological differences, internal Zhongzhou divergence, 四化 assignment contradictions); **天同/廉贞 star-nature verification** against web-search sources.

## Current state
- No source is marked `COMPLETE` yet.
- Sources 7, 8, 10, 11 now at `Medium-High` depth with chapter-level quote-backed extraction and English translation layer.
- Sources 9, 12, 13, 14 at `High` depth (BATCH_06).
- Sources 15 at `Medium-High` depth (BATCH_06/08), now 13 of 64 hexagrams line-extracted with Chinese+English.
- Sources 17, 18, 19, 20 at `Medium-High` depth (BATCH_04/06).
- Sources 1–6 (Western) at `Medium` structural depth (BATCH_06).
- Source 16 (王弼) at `Medium-High` depth (BATCH_04/08), 得意忘象 method demonstrated with specific hexagram examples (乾, 坤, 复, 临).
- **New in BATCH_08:** Yi Jing three-school contradiction matrix (Wang Bi–Cheng Yi–Zhu Xi) and Zi Wei four-school taxonomy + contradiction matrix built.
- All Zi Wei / Mingli sources (7–14) now have comprehensive Chinese→English translation layers.
- Cross-source consistency notes maintained across all batches.
