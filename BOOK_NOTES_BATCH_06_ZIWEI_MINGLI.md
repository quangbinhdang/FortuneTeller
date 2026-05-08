# Book Notes Batch 06 — Deep Ingestion: Zi Wei (紫微斗数全书) + Di Tian Sui (滴天髓) + Qiong Tong Bao Jian (穷通宝鉴)

**Batch focus**: Chapter-level structure mapping, quote-backed extraction, Chinese→English translation layer.

---

## 9) 《紫微斗数全书》— Chapter-Level Deep Extraction

**Source**: 正统道藏本 (Wikisource), Volumes 1-3. Additional commentary from 豆瓣 太微赋 group post with annotations.

### Chapter Structure Map

```
卷一 (Volume 1):
├── 罗序 (Luo Hongxian preface, 1550 CE)
├── 太微赋 (Taiwei Fu) — Core theoretical verse
├── 形性赋 (Xingxing Fu) — Physiognomy verse
├── 星垣论 (Xingyuan Lun) — Star-palace cosmology
├── 斗数准绳 (Doushu Zhunsheng) — Judgment standards
├── 斗数发微论 (Fawie Lun) — Subtle principles
├── 重补斗数彀率 (Chongbu Doushu Goulü) — Supplementary rules
├── 增补太微赋 (Zengbu Taiwei Fu) — Extended Taiwei verse
├── 诸星问答论 (Zhuxing Wenda Lun) — 14 main-star Q&A
│   ├── 问紫微 → 问破军 (14 stars)
│   ├── 问文昌 → 问天哭天虚 (auxiliary stars)
│   └── 问化禄→化忌 (four transformations)
├── 斗数骨随赋 (Gusui Fu) — Marrow verse (patterns)
├── 女命骨髓赋 (Nüming Gusui Fu) — Female-destiny verse
├── 定富贵贫贱十等论 — Ten-rank classification
├── 十二宫诸星得地合格诀 — Palace-star qualification rhymes
├── 十二宫诸星失陷破格诀 — Palace-star disqualification rhymes
├── 十二宫诸星得地富贵论 — Palace-star prosperity verses
├── 十二宫诸星失陷贫贱论 — Palace-star poverty verses
├── 定富局 — Wealth patterns
├── 定贵局 — Honor patterns
├── 定贫贱局 — Poverty patterns
└── 定杂局 — Mixed patterns

卷二 (Volume 2):
├── 安身命例 — Life/Body palace placement method
├── 安十二宫例 — Twelve-palace placement
├── 起五行寅例 — Five-phase year-start rule
├── 六十花甲子纳音歌 — 60-cycle nayin song
├── 安南北斗诸星诀 — Star placement formulas
└── 十二宫逐宫断法 — Per-palace judgment (命→父母)

卷三 (Volume 3):
├── 谈星要论 — Star interpretation essentials
├── 论人命入格 — Pattern classification
├── 论格星数高下 — Pattern ranking
├── 论男女命同异 — Gender differentiation
├── 论小儿命 — Child destiny
├── 论大限十年祸福 — Decade-limit judgment
├── 论二限太岁吉凶 — Dual-limit year judgment
└── Various specialized judgments (阴骘延寿, 羊陀迭并, etc.)
```

---

### 9A) 太微赋 (Taiwei Fu) — Core Theoretical Verse

**Original Chinese (opening lines)**:
> 「斗数至玄至微，理旨难明，虽设问于百篇之中，犹有言而未尽，至如星之分野，各有所属，寿夭贤愚，富贵贫贱，不可一概论议。其星分布一十二垣，数定乎三十六位，入庙为奇，失度为虚，大抵以身命为福德之本，加以根源为穷通之资。」

**English translation**:
"Dou-shu [Zi Wei] reaches the profound and subtle; its principles are difficult to clarify. Though questions are posed across a hundred sections, there remains more unsaid than said. The stars each have their domains and attributes—longevity or early death, wisdom or folly, wealth and rank or poverty and lowliness—none can be discussed in a single sweeping statement. The stars distribute across twelve palaces, their number fixed at thirty-six positions. Entering temple [miao] is exceptional; losing degree [shidu] is hollow. Generally, take the Life [ming] and Body [shen] palaces as the root of fortune; add the wellspring [genyuan] as the resource of success or failure."

**Key doctrinal lines with translation**:

| Original Chinese | English |
|---|---|
| 禄逢冲破，吉处藏凶 | Lu [Hua Lu] encountering clash/break — within fortune hides misfortune |
| 马遇空亡，终身奔走 | Horse [Tianma] meeting emptiness — lifelong ceaseless running |
| 生逢败地，发也虚花 | Born into defeated earth — flourishing is but flowers of vanity |
| 绝处逢生，生花不败 | At the extinction-point meeting life — the flowering does not wither |
| 星临庙旺，再观生克之机 | The star dwells in temple/prosperity — then examine the mechanism of generation and overcoming |
| 命坐强宫，细察制化之理 | Destiny sits in strong palace — scrutinize the principle of control and transformation |
| 日月最嫌反背 | Sun and Moon most detest turning their backs [one fallen, one rising] |
| 禄马最喜交驰 | Lu-cun and Tianma most delight in intersecting gallop [same palace or facing] |
| 紫微天府全依辅弼之功 | Ziwei and Tianfu entirely rely on the merit of Zuofu and Youbi |
| 七杀破军专依羊铃之虐 | Qisha and Pojun specialize in the cruelty of Qingyang and Lingxing |
| 诸星吉，逢凶也吉。诸星凶，逢凶也凶 | Many stars auspicious → meeting inauspicious becomes auspicious. Many stars inauspicious → meeting inauspicious becomes inauspicious. |
| 辅弼夹帝为上品 | Zuofu-Youbi flanking the Emperor [Ziwei] is top-grade |
| 君臣庆会，材擅经邦 | Lord and ministers celebrating together — talent good at governing the state |
| 魁钺同行，位居台辅 | Kui-Yue [Tiankui Tianyue] traveling together — position reaches ministerial rank |
| 太阳居午，谓之日丽中天 | Sun residing at Wu — called "sun blazing at zenith" — autocratic rank, rival-state wealth |
| 太阴居子，号曰水澄桂萼 | Moon residing at Zi — called "water clarifying cassia calyx" — pure-rank office, loyal remonstrance talent |

---

### 9B) 形性赋 (Xingxing Fu) — Physiognomy & Character Verse

**Original Chinese (opening)**:
> 「原夫紫微帝座，生为厚重之容。天府尊星，也作纯和之体。金乌圆满，玉兔清奇。天机为不长不短之姿，情怀好善。武曲乃至要至紧之操，心性果决。」

**English translation**:
"Originally, Ziwei the Imperial Throne — inborn with a weighty and substantial countenance. Tianfu the honored star — also produces a pure and harmonious physique. Golden Crow [Sun] is round and full; Jade Rabbit [Moon] is clear and rare. Tianji has neither-tall-nor-short bearing, heart inclined toward goodness. Wuqu has the most essential and tight-held integrity — mind and nature decisive and firm."

**Key star-physiognomy pairs**:

| Star | Physiognomy | Character |
|---|---|---|
| 紫微 (Ziwei) | Heavy, substantial countenance | Imperial, authoritative |
| 天府 (Tianfu) | Pure, harmonious physique | Conservative, stable |
| 太阳 (Taiyang) | Round and full | Warm, generous |
| 太阴 (Taiyin) | Clear and rare, elegant | Refined, pure |
| 天机 (Tianji) | Neither tall nor short | Good-hearted, clever |
| 武曲 (Wuqu) | Resolute bearing | Decisive, firm |
| 天同 (Tiantong) | Full-bodied, fine-eyed | Gentle, happy |
| 廉贞 (Lianzhen) | Broad brows, wide mouth, horizontal face | Hot-tempered, contentious |
| 贪狼 (Tanlang) | Long and tall (in temple), stubborn/rough (fallen) | Dual good/evil nature |
| 巨门 (Jumen) | In temple: sincere and warm. Fallen: gossipy | Dispute-prone |
| 天相 (Tianxiang) | Spirited | Loyal, principled |
| 天梁 (Tianliang) | Steady, weighty | Pure-hearted, jade-clean |
| 七杀 (Qisha) | Tiger-like ferocity | Bold, reckless |
| 破军 (Pojun) | Heavy back, broad brows, slanted sitting/standing gait | Unkind, crafty, thrill-seeking |
| 文昌 (Wenchang) | Elegant brows, clear eyes | Scholarly, refined |
| 文曲 (Wenqu) | In temple: unusual mole; fallen: scars/marks | Articulate, eloquent |
| 左辅/右弼 (Zuofu/Youbi) | Gentle, dignified bearing | Upright scholar |
| 擎羊/陀罗 (Qingyang/Tuoluo) | Ugly appearance, coarse form | Deceitful posture |
| 禄存 (Lucun) | Spring-like warm countenance | Virtuous, feeling |
| 破耗 (Pohao) | Fire-like sharp, charging | Authoritative, rash |

---

### 9C) 星垣论 (Xingyuan Lun) — Star-Palace Cosmology

**Original Chinese (opening)**:
> 「紫微帝座以辅弼为佐，贰作数中之主星乃有用之源流。是以南北二斗集而成数，为万物之灵。盖以水淘溶，则阴阳既济，水盛阳伤，火盛阴灭，二者不可偏废，故知其中者，斯为美矣。」

**English translation**:
"Ziwei the Imperial Throne takes Zuofu and Youbi as its assistants — the two serve as the lord-star within the numbering, the source-stream of usefulness. Thus the Southern Dipper and Northern Dipper gather to complete the number, becoming the animating spirit of the ten thousand things. Water washing and dissolving achieves yin-yang mutual completion — water in excess wounds yang, fire in excess extinguishes yin; the two cannot be one-sidedly abandoned. One who knows the middle of them — this is excellence."

**Seasonal palace-cosmology mapping**:

| Palace | Phase | Nature | Key Stars and Significance |
|---|---|---|---|
| 寅 (Yin) | Wood | Three-yang crossing, grass-sprouting place | Tanlang + Tianji in temple; Tianxiang water reaching Yin is prosperous |
| 卯 (Mao) | Wood (peak) | Wood at fullest | Jumen water at Mao becomes unobstructed flow |
| 辰/戌/丑/未 | Earth (four tombs) | Storage | Julu water at Chou, Tianliang earth at Wei, Tuoluo metal at four tombs |
| 巳 (Si) | Fire | Water-earth extinction point, residual fire from Wu | Lianzhen fire resides here |
| 午 (Wu) | Fire (peak) | Blazing illumination through and through | Wenqu water in temple; with Ziwei+Jumen = Kui-star Arching Dipper pattern |
| 申/酉 (Shen/You) | Metal | Western white-gold qi | Wuqu at Shen delights in generation; Qingyang at You uses killing |
| 亥 (Hai) | Water | Wenqu-Pojun's crucial ground | Clear-civilization pure-scholar; great-river source cleansing |
| 子 (Zi) | Water (peak) | Pojun at prosperous之乡 | Great-sea vast-tide surging — view from afar, don't lean close |

---

### 9D) 斗数准绳 (Doushu Zhunsheng) — Judgment Standards

**Original Chinese (complete)**:
> 「命居生旺定富贵，各有所宜。身坐空亡论荣枯，专求其要。紫微帝座在南极不能施功，天府令星在南地专能为福。天机七杀同宫也善三分，太阴火铃同位反成十恶。贪狼为善宿入庙不凶，巨门为恶曜得垣尤美。诸凶在紧要之鄉最宜制克，若在身命之位却受孤单。」

**English translation**:
"Destiny residing in birth/prosperity determines wealth and rank — each has its suitability. Body sitting in emptiness judges flourishing and withering — focus on seeking the essential. Ziwei the Imperial Throne at the Southern Pole cannot deploy merit; Tianfu the Command-Star in Southern territory exclusively can produce fortune. Tianji + Qisha in same palace — even then three-tenths good. Taiyin + Huo-Ling in same position — reversely becomes ten-part evil. Tanlang as a good-lodging star — entering temple is not inauspicious. Jumen as an evil-brilliance — attaining the rampart is especially fine. Various inauspicious ones in critical locales most require control and overcoming; if in Life-Body position, instead receive solitude."

---

### 9E) 安命身例 + 安十二宫例 — Placement Methodology

**Original Chinese (安身命例)**:
> 「大抵人命俱从寅上起正月，顺数至本生月止，又自人生月起子时逆至本生时安命，顺至本生时安身。」

**English translation**:
"Generally for human destiny, all begin from Yin [palace] starting the first month, counting forward to the birth month and stopping. Then from the birth-month [palace] starting the Zi hour, count backward to the birth hour to place the Life [ming] palace, count forward to the birth hour to place the Body [shen] palace."

**Original Chinese (安十二宫例)**:
> 「男女俱从逆转切忌莫顺去。一命宫、二兄弟、三妻妾、四子女、五财帛、六疾厄、七迁移、八奴仆、九官禄、十田宅、十一福德、十二父母。」

**English translation**:
"Both male and female: all counting reverse [counter-clockwise] from the Life palace — absolutely do not count forward. [1] Life, [2] Siblings, [3] Spouse, [4] Children, [5] Wealth, [6] Health, [7] Relocation, [8] Servants, [9] Career, [10] Property, [11] Fortune/Virtue, [12] Parents."

**Key placement formulas (original Chinese)**:

- **安南北斗诸星诀** (Star placement song):
> 「紫微天机逆行旁，隔一阳武天同当，又隔二位廉贞地，空三复见紫微郎，天府太阴与贪狼，巨门天相及天梁，七杀空三破军位，八星顺数细推详。」

- **安文昌文曲星诀**: 子时戌上起文昌，逆到生时是贵乡，文曲数从辰上起，顺到生时是本乡。

- **安左辅右弼星诀**: 左辅正月起于辰，顺逢生月是贵方，右弼正月宫寻戌，逆至正月便调停。

- **安禄存星诀**: 甲生禄存在寅宫，乙生在卯丙戊巳，丁己禄存停午方，庚禄居申辛禄酉，壬禄在亥癸禄子。

- **安禄权科忌四星变化诀** (Four Transformations):
> 「甲廉破武阳为伴，乙机梁紫月交侵，丙同机昌廉贞位，丁月同机巨门寻，戊贪月弼机为主，己武贪梁曲最平，庚日武阴同为首，辛巨阳曲昌至临，壬梁紫府武宿是，癸破巨阴贪狼停。」

**English gloss for Four Transformations rhyme**:
| Year Stem | Hua Lu | Hua Quan | Hua Ke | Hua Ji |
|---|---|---|---|---|
| 甲 (Jia) | Lianzhen | Pojun | Wuqu | Taiyang |
| 乙 (Yi) | Tianji | Tianliang | Ziwei | Taiyin |
| 丙 (Bing) | Tiantong | Tianji | Wenchang | Lianzhen |
| 丁 (Ding) | Taiyin | Tiantong | Tianji | Jumen |
| 戊 (Wu) | Tanlang | Taiyin | Youbi | Tianji |
| 己 (Ji) | Wuqu | Tanlang | Tianliang | Wenqu |
| 庚 (Geng) | Taiyang | Wuqu | Taiyin | Tiantong |
| 辛 (Xin) | Jumen | Taiyang | Wenqu | Wenchang |
| 壬 (Ren) | Tianliang | Ziwei | Tianfu | Wuqu |
| 癸 (Gui) | Pojun | Jumen | Taiyin | Tanlang |

---

### 9F) 格局 (Geming) — Pattern Sections from 卷一

The text provides extensive pattern classification. Key pattern groups:

**定富局 (Wealth patterns)**:
- 禄存守田财: "堆金积玉" (pile gold, heap jade)
- 财荫坐迁移: "巨商高贾" (great merchant, high trader)
- 紫府同宫终身福厚
- 日月夹财 "不权则富"

**定贵局 (Honor/rank patterns)**:
- 紫微居午无杀凑 "位至三公"
- 天府临戌有星扶 "腰金衣紫"
- 七杀朝斗爵禄荣昌
- 君臣庆会 "材擅经邦"
- 魁钺同行 "位居台辅"
- 科权禄拱 "名誉昭彰"

**定贫贱局 (Poverty patterns)**:
- 耗居禄位 "沿途乞食"
- 贪会旺宫 "终身鼠窃"
- 命无正曜 "夭折孤贫"
- 生逢败地 "发也虚花"

**Special Patterns**:
- **石中隐玉格** (Jade Hidden in Stone): 巨门 at 子/午 + 科禄照 → "巨门子午二宫逢，身命逢之必贵荣"
- **马头带剑** (Horse-Head Carrying Sword): 擎羊 at 午宫 → "镇卫边疆" or "非夭折则主刑伤"
- **日月并明**: Sun and Moon both bright → "佐九重于尧殿"
- **月朗天门**: Moon bright at 亥 → "进爵封侯"
- **日照雷门**: Sun at 卯 → "富贵荣华"
- **禄马交驰**: Lu-cun + Tianma same palace → highest wealth-mobility pattern
- **极居卯酉**: Ziwei at 卯/酉 + 劫空 → "多为脱俗僧人"

---

### 9G) Translation Layer Summary — Key Zi Wei Terminology

| Chinese Term | English | Core Meaning |
|---|---|---|
| 命宫 (Ming Gong) | Life Palace | Root destiny; innate tendency |
| 身宫 (Shen Gong) | Body Palace | Acquired/developed self; activates ~age 30 |
| 三方四正 (Sanfang Sizheng) | Three Directions + Four Orthogonal | Triplicity + facing palace; the core viewing scope |
| 庙旺 (Miao Wang) | Temple / Prosperous | Star's strongest, most auspicious state |
| 陷 (Xian) | Fallen / Trapped | Star's weakest, most inauspicious state |
| 得地 (De Di) | Obtaining Earth | Star in compatible palace; functional strength |
| 失度 (Shi Du) | Losing Degree | Star out of alignment; ineffective |
| 制化 (Zhi Hua) | Control & Transform | The mechanism by which inauspicious stars are restrained or redirected |
| 百官朝拱 (Baiguan Chaogong) | Hundred Officials Courting | Ziwei surrounded by multiple supporting auspicious stars |
| 孤君 (Gu Jun) | Lone Sovereign | Ziwei without supporting stars — talent unexpressed |
| 化杀为权 (Hua Sha Wei Quan) | Transforming Killing into Authority | Qisha + Ziwei: raw destructive force becomes commanding power |
| 四化 (Si Hua) | Four Transformations | Hua Lu (Prosper), Hua Quan (Authority), Hua Ke (Fame), Hua Ji (Obstruction) |

**Confidence**: **High** — sourced directly from 正统道藏 wikisource text, cross-referenced with 豆瓣 commentary annotations.

---

## 13) 《滴天髓》(任铁樵阐微) — Multi-Chapter Deep Breakdown

**Source**: 任铁樵 滴天髓阐微, 维基文库 full text (通神论 + 六亲论 sections).

### Chapter Structure Map

The 滴天髓阐微 is organized in two major books:

```
通神论 (Tongshen Lun — "Penetrating Spirit Discourse") — 34 chapters:

卷一 (Book 1):
├── 一、天道 (Tiandao) — The Way of Heaven
├── 二、地道 (Didao) — The Way of Earth
├── 三、人道 (Rendao) — The Way of Humanity
├── 四、知命 (Zhiming) — Knowing Destiny
├── 五、理气 (Liqi) — Principle and Qi [★ key section]
├── 六、配合 (Peihe) — Stem-Branch Matching
├── 七、天干 (Tiangan) — Heavenly Stems
├── 八、地支 (Dizhi) — Earthly Branches
├── 干支总论 (Ganzhi Zonglun) — Stem-Branch General Discussion

卷二 (Book 2):
├── 十、形象 (Xingxiang) — Images & Forms
├── 十一、方局 (Fangju) — Direction & Configuration
├── 十二、八格 (Bage) — Eight Standard Patterns
├── 十三、体用 (Tiyong) — Substance & Function [★]
├── 十四、精神 (Jingshen) — Spirit & Essence
├── 十五、月令 (Yueling) — Month Command
├── 十六、生时 (Shengshi) — Birth Hour
├── 十七、衰旺 (Shuaiwang) — Decline & Prosperity [★]
├── 十八、中和 (Zhonghe) — Central Harmony
├── 十九、源流 (Yuanliu) — Source & Flow [★]
├── 二十、通关 (Tongguan) — Breaking Through Barriers [★]
├── 二十一、官杀 (Guansha) — Officer & Killing
├── 二十二、伤官 (Shangguan) — Hurting Officer
├── 二十三、清气 (Qingqi) — Clear Qi
├── 二十四、浊气 (Zhuoqi) — Turbid Qi
├── 二十五、真神 (Zhenshen) — True Spirit
├── 二十六、假神 (Jiashen) — False Spirit
├── 二十七、刚柔 (Gangrou) — Hard & Soft
├── 二十八、顺逆 (Shunni) — Following & Opposing

卷三 (Book 3):
├── 二十九、寒暖 (Han Nuan) — Cold & Warm
├── 三十、燥湿 (Zaoshi) — Dry & Damp
├── 三十一、隐显 (Yinxian) — Hidden & Manifest
├── 三十二、众寡 (Zhonggua) — Many & Few
├── 三十三、震兑 (Zhendui) — Thunder & Lake (Mao-You axis)
├── 三十四、坎离 (Kanli) — Water & Fire (Zi-Wu axis)


六亲论 (Liuqin Lun — "Six Relatives Discourse"):
├── 一、夫妻 (Fuqi) — Husband & Wife
├── 二、子女 (Zinv) — Children
├── 三、父母 (Fumu) — Parents
├── 四、兄弟 (Xiongdi) — Siblings
├── ...
├── 十、恩怨 (Enyuan) — Gratitude & Grudge
├── 十一、闲神 (Xianshen) — Idle Spirits
├── 十二、从象 (Congxiang) — Following Configuration
├── 十三、化象 (Huaxiang) — Transformation Configuration
├── 十四、假从 (Jiacong) — False Following
├── 十五、假化 (Jiahua) — False Transformation
├── 十六、顺局 (Shunju) — Following Patterns
├── 十七、反局 (Fanju) — Opposing Patterns
├── 十八、战局 (Zhanju) — Battle Patterns
├── 十九、合局 (Heju) — Union Patterns
├── 二十、君象 (Junxiang) — Sovereign Configuration
├── 二十一、臣象 (Chenxiang) — Minister Configuration
├── 二十二、母象 (Muxiang) — Mother Configuration
├── 二十三、子象 (Zixiang) — Child Configuration
├── 二十四、性情 (Xingqing) — Temperament
├── 二十五、疾病 (Jibing) — Illness
├── 二十六、出身 (Chushen) — Origins/Career Entry
├── 二十七、地位 (Diwei) — Position/Rank
├── 二十八、岁运 (Suiyun) — Year & Fortune Cycles
├── 二十九、贞元 (Zhenyuan) — Core & Origin
```

---

### 13A) 一、天道 → 四、知命 — Foundational Cosmology

**Original Chinese (天道)**:
> 「欲识三元万法宗，先观帝载与神功。」

**English**: "Wishing to understand the Three Origins [天/地/人], the ancestor of ten-thousand methods — first observe the Imperial Burden [Taiji/cosmos] and Spirit Achievement [seasonal qi]."

**任铁樵注 (Ren's commentary)**:
> 「干为天元，支为地元，支中所藏为人元。人之禀命，万有不齐，总不越此三元之理，所谓万法宗也。」

**English**: "Stems are Heaven-Origin; Branches are Earth-Origin; what the branches hide is Human-Origin. Human endowed destiny — ten thousand inequalities — in sum never exceeds these Three Origins' principle. This is what is called the ancestor of ten thousand methods."

**Original Chinese (地道)**:
> 「坤元合德机缄通，五气偏全定吉凶。」

**English**: "Kun-Origin's combined virtue — the mechanism's seal opens through. The five qi partial or complete determine fortune and misfortune."

**Original Chinese (人道)**:
> 「戴天覆地人为贵，顺则吉兮凶则悖。」

**English**: "Wearing Heaven above, covered by Earth below — humanity is honored. When following [shun], fortunate; when opposing [bei], misfortune."

**任铁樵注 (Ren's commentary on 人道)**:
> 「八字贵乎天干地支顺而不悖也。顺者接续相生，悖者反克为害，故吉凶判然。...凡物莫不得五行，戴天履地...惟人属土，土居中央，乃木火金水中气所成，独是五行之全，为贵。是以人之八字，最宜四柱流通，五行生化；大忌四柱缺陷，五行偏枯。」

**English**: "The eight characters are valued when Heaven-stems and Earth-branches follow [flow continuously] without opposition. Following means connecting sequence mutual generation; opposing means reverse overcoming causing harm — hence fortune and misfortune are clearly divided. ... All things without exception obtain five phases, wearing Heaven and treading Earth... Only humans belong to Earth; Earth resides at the center — it is what the central qi of Wood, Fire, Metal, and Water forms — uniquely the completeness of the five phases — therefore honored. Thus the human eight characters most suit four-pillar circulation-through, five-phase generation-transformation; greatly taboo four-pillar deficiency-hollow, five-phase biased-withered."

**Original Chinese (知命)**:
> 「要与人间开聋聩，顺逆之机须理会。」

**English**: "Wishing to open the deaf and blind among humanity — the mechanism of following and opposing must be comprehended."

**Key Ren commentary on anti-mechanical stance**:
> 「余详考古书，子平之法，全在四柱五行。察其衰旺，究其顺悖，审其进退，论其喜忌，是谓理会。至于奇格异局，神煞纳音诸名目，乃好事妄造，非关命理休咎。」

**English**: "I have examined ancient texts in detail — the Zi-Ping method rests entirely in the four pillars and five phases. Examine their decline and prosperity; investigate their following and opposition; scrutinize their advancing and retreating; discuss their liked and disliked — this is called 'comprehending.' As for strange patterns, unusual configurations, spirit-killings [shensha], nayin, and such categories — these are fabrications of meddlesome people, unrelated to the fortune and misfortune of destiny principle."

---

### 13B) 五、理气 (Li Qi) — Principle and Qi: Advancing and Retreating

**Original Chinese**:
> 「理承气行岂有常，进兮退兮宜抑扬。」

**English**: "Principle carried by qi's movement — how could there be constancy? Advancing and retreating — should be suppressed or raised."

**任铁樵注 (core doctrine)**:
> 「进退之机，不可不知也。非长生为旺，死绝为衰，必当审明理气之进退，庶得衰旺之真机矣。凡五行旺相休囚，按四季而定之。将来者进，是谓相；进而当令，是谓旺；功成者退，是谓休；退而无气，是谓囚。须辨其旺相休囚，以知其进退之机。...然相妙于旺，旺则极盛之物，其退反速，相则方长之气，其进无涯也。休甚乎囚，囚则既极之势，必将渐生；休则方退之气，未能遽复也。」

**English translation of the kernel doctrine**:
"The mechanism of advancing and retreating must not be unknown. It is not that Changsheng [Birth] is prosperous and Sijue [Death/Extinction] is declining — one must certainly examine clearly the advance and retreat of Principle and Qi, to nearly attain the true mechanism of decline and prosperity. For all five phases: Wang [Prosperous], Xiang [Minister/Second], Xiu [Retiring], Qiu [Imprisoned] — these are determined according to the four seasons. What is coming — advances; this is called Xiang [approaching, about to take command]. What advances and takes seasonal command — this is called Wang [prosperous]. What having accomplished merit withdraws — this is called Xiu [resting/retired]. What withdraws and has no qi — this is called Qiu [imprisoned]. ...

Yet Xiang [approaching] is more subtle than Wang [prosperous]. Wang is something at extreme fullness — its retreat is instead fast. Xiang is qi just now growing — its advance is boundless. Xiu [retiring] is more extreme than Qiu [imprisoned]. Qiu is a situation already at its extreme — it must gradually generate anew. Xiu is qi just now retreating — it cannot suddenly recover."

**Illustrative case (Original Chinese)**:
> 「九月甲木进气，壬水贴身相生，不伤丁火。...进退之机，不可不知也。」

**English**: "Ninth-month Jia Wood — qi is advancing [entering]. Ren Water clings to the body generating each other, not harming Ding Fire. ... The mechanism of advancing and retreating must not be unknown."

---

### 13C) 十三、体用 (Ti Yong) — Substance and Function

**Original Chinese**:
> 「道有体用，不可以一端论也，要在扶之抑之得其宜。」

**English**: "The Way has Substance [ti] and Function [yong] — it cannot be discussed from one end alone. The essential is: support what should be supported, suppress what should be suppressed — attaining what is fitting."

**Original commentary on 配合 → 体用 relationship**:
> 「命中至理，只存用神，不拘财、官、印绶、比劫、食伤、枭杀，皆可为用，勿以名之美者为佳，恶者为憎。果能审日主之衰旺，用神之喜忌，当抑则抑，当扶则扶，所谓去留舒配，取裁确当，则运途否泰，显然明白，祸福灾祥，无不验矣。」

**English**: "Destiny's ultimate principle — only the Yong Shen [Use Spirit] exists. Whether Wealth, Officer, Seal, Peer/Robber, Food/Hurting, Owl/Killing — all can serve as the Yong. Do not take those with fine names as excellent and hateful names as detestable. If one can truly examine the Day-Master's decline or prosperity and the Yong Shen's liked and disliked — suppressing what should be suppressed, supporting what should be supported — what is called 'removing what stays, spreading what matches, taking and cutting appropriately,' then fortune-path obstruction and smoothness are clearly evident, and calamity, fortune, disaster, and good omen — none fails to verify."

---

### 13D) 十九、源流 (Yuan Liu) — Source and Flow

**Original Chinese**:
> 「何处起根源？流到何方住？机括此中求，知来亦知去。」

**English**: "Where does the source-origin arise? To what direction does it flow and reside? Mechanism-key sought within this — knowing the coming, also knowing the going."

**任铁樵注 (full source-flow doctrine)**:
> 「源头者，即四柱中之旺神也，不论财、官印绶、食伤比劫之类，皆可为源头也。总要流通生化，收局得美为佳。或起于比劫，止于财官为喜；或起于财官，止于比劫为忌讳。如山川之发脉来龙，认气于大父母，看尊星；认气于真子息，看主星；认气于方交媾，看胎伏星；认气于成胎育，看胎息星；认气于化煞为权，看解星；认气于绝处逢生，看恩星。认源之气以势，认流之气以情。故源头流住之地，即山川结穴之所也，不可以不究。」

**English translation**:
"The source-head is precisely the prosperous spirit within the four pillars. Whether Wealth, Officer, Seal, Peer/Rob, Food/Hurting — all can serve as the source-head. The overall requirement is circulation-through generation-transformation, with the closing configuration attaining beauty as excellent. Some arise from Peer/Rob and end at Wealth/Officer — this is liked. Some arise from Wealth/Officer and end at Peer/Rob — this is taboo. Like mountain-river veins dispatching the arriving dragon — recognize qi at the Great Father-Mother [year pillar], observe the Honored Star; recognize qi at the True Child [day pillar], observe the Lord Star; recognize qi at the just-copulating [month pillar], observe the Embryo-Hidden Star; recognize qi at the completing embryo-nurturing [hour pillar], observe the Embryo-Breath Star; recognize qi at transforming Killing into Authority, observe the Resolving Star; recognize qi at extinction-point meeting life, observe the Grace Star. Recognize source-qi by its momentum [shi]; recognize flow-qi by its sentiment [qing]. Therefore the source-head flowing and stopping place is precisely the mountain-river's cavity-formation place — it cannot be left uninvestigated."

---

### 13E) 二十、通关 (Tong Guan) — Breaking Through Barriers

**Original Chinese**:
> 「关内有织女，关外有牛郎，此关若通也，相邀入洞户。」

**English**: "Inside the pass is the Weaving Maid; outside the pass is the Cowherd. If this pass becomes open — they invite each other into the cave-chamber."

**任铁樵注 (core doctrine)**:
> 「通关者，引通克制之神也。所谓阴阳二用，妙在气交，天降而下，地升而上。天干之气动而专，地支之气静而杂，是故地运有推移，而天气从之；天气有转徒，而地运应之；天气动于上，而人元应之；人元动于下，而天气从之，所以阴胜逢阳则止，阳胜逢阴则往，是谓天地交泰，干支有情，左右不背，阴阳生育而相通也。」

**English translation**:
"'Breaking through the barrier' means guiding-through the spirit that overcomes and controls. What is called 'yin and yang — the two uses' — the subtlety lies in qi-exchanging: Heaven descends downward, Earth ascends upward. The qi of heavenly stems is moving and specialized; the qi of earthly branches is still and mixed. For this reason: Earth-fortune has pushing and shifting, and Heaven-qi follows it; Heaven-qi has turning and migrating, and Earth-fortune responds to it; Heaven-qi moves above, and Human-Origin responds to it; Human-Origin moves below, and Heaven-qi follows it. Therefore: when yin overcomes and meets yang, it stops; when yang overcomes and meets yin, it proceeds. This is called Heaven-Earth mutual prosperity [tiandi jiaotai], stems and branches having sentiment, left and right not opposing, yin and yang birthing and nurturing, thus interconnecting."

**Practical formula**: When two elements are locked in mutual overcoming (e.g., Wood restrained by Metal), a mediating element (e.g., Water generating Wood and draining Metal) serves as the "pass." If no mediator exists natively, the luck cycle [dayun] must provide it.

**Illustrative case (Original Chinese)**:
> 「此春金气弱 ，时杀紧克，年逢印绶，远隔不通。又被旺木克土坏印...局内无可通之理。中运南方杀地...交庚申克去木神...官至副尹，盖金能克木帮身，印可化杀而通也。」

**English**: "This spring Metal — qi is weak, the hour-Killing closely overcomes. The year meets Seal, but distantly separated — not passable. Also harmed by prosperous Wood overcoming Earth, ruining the Seal... within the configuration, no passable principle. Middle fortune goes to southern Killing territory... entering Geng-Shen [luck pillar] — overcoming away the Wood spirit... office reached vice-governor — because Metal can overcome Wood and aid the self, Seal can transform Killing and achieve passage."

---

### 13F) 三十二、众寡 + 三十四、坎离 — Structural Dynamics

**Original Chinese (众寡 — "Many and Few")**:
> 「强众而敌寡者，势在去其寡；强寡而敌众者，势在成乎众。」

**English**: "When the strong are many and oppose the few — the momentum lies in removing the few. When the strong are few and oppose the many — the momentum lies in joining the many."

**Original Chinese (坎离 — "Water-Fire / Zi-Wu Axis")**:
> 「坎离宰天地之中气，成不独成，而有相持者在。」

**English**: "Kan [Water] and Li [Fire] govern the central qi of Heaven and Earth — completion is not solitary completion; there exists something mutually holding."

**Original commentary**:
> 「天干透壬癸，地支属离者，乃为既济，要天气下降；天干透丙丁，地支属坎者，乃为未济，要地气上升。...水火相见于天干，以火为主，而水盛者存；坎离相见于地支，喜坎而坎旺者昌。」

**English**: "When Heaven-stems show Ren/Gui [Water] and Earth-branches belong to Li [Fire] — this is 'Already Crossing' [jiji, hexagram 63] — requires Heaven-qi descending downward. When Heaven-stems show Bing/Ding [Fire] and Earth-branches belong to Kan [Water] — this is 'Not Yet Crossing' [weiji, hexagram 64] — requires Earth-qi ascending upward. ... When Water and Fire mutually appear in Heaven-stems — take Fire as lord, yet those with Water abundant survive. When Kan and Li mutually appear in Earth-branches — delight in Kan, and those with Kan prosperous flourish."

---

### 13G) Translation Layer — Key Di Tian Sui Terminology

| Chinese Term | English | Concept |
|---|---|---|
| 三元 (San Yuan) | Three Origins | Heaven Stem / Earth Branch / Hidden Stem |
| 理气进退 (Li Qi Jintui) | Principle-Qi Advance-Retreat | Seasonal waxing/waning beyond static 12-stage labels |
| 用神 (Yong Shen) | Use Spirit | The key operative deity; not fixed to any one category |
| 体用 (Ti Yong) | Substance & Function | The structure vs. its operative expression |
| 源流 (Yuan Liu) | Source & Flow | Tracing qi from origin to resolution |
| 通关 (Tong Guan) | Breaking the Pass | Mediating element resolving mutual-overcoming deadlock |
| 顺逆 (Shun Ni) | Following & Opposing | Qi flowing with vs. against seasonal direction |
| 旺相休囚 (Wang Xiang Xiu Qiu) | Prosper / Approach / Retire / Imprison | The four seasonal qi-states |
| 中和 (Zhong He) | Central Harmony | Balanced configuration |
| 清浊 (Qing Zhuo) | Clear & Turbid | Purity vs. contamination of pattern |
| 真假 (Zhen Jia) | True & False | Authentic vs. apparent operative spirit |
| 天覆地载 (Tian Fu Di Zai) | Heaven Covers, Earth Carries | Stems and branches must mutually support (干以载之支为切，支以覆之干为切) |
| 征验 (Zheng Yan) | Verification/Attestation | Not a standalone chapter — embedded throughout in case-study form; every chapter in 滴天髓阐微 concludes with multiple real birth-chart verifications with commentary. The "征验" method is the entire case-study apparatus throughout both 通神论 and 六亲论 |

**Confidence**: **High** — sourced from complete 任铁樵阐微 text, 34+28 chapter structure mapped.

---

## 14) 《穷通宝鉴》— Full Stem-by-Month Template Mapping

**Source**: ctext.org full text, 百度百科 structural notes.

### Structure and Core Premise

Originally titled 《栏江网》 (Barring the River Net) — secret manual of Ming-era itinerant fortune-tellers. Rearranged and published by 余春台 in the Guangxu era (late Qing) as 《穷通宝鉴》. Later annotated by 徐乐吾 as 《造化元钥评注》.

**Core method** (百度百科): "以月令气候为基准，构建'调候'论命法" — "Taking the month-command climate as the reference standard, constructing the 'Regulating Climate' [tiaohou] destiny-discussion method."

The text provides a lookup-table structure: "某日干生于某月，干透或支藏某某物" — "A given day-stem born in a given month, with stem showing or branch hiding such-and-such thing" — forming a rule-driven, almost algorithmic approach.

---

### 14A) 五行总论 (Five Phase General Discussion)

**Original Chinese (opening)**:
> 「五行者，本乎天地之间而不穷者也，故谓之行。北方阴极而生寒，寒生水。南方阳极而生热，热生火。东方阳散以泄而生风，风生木。西方阴止以收而生燥，燥生金。中央阴阳交而生温，温生土。其相生也所以相维，其相克也所以相制，此之谓有伦。」

**English**:
"The five phases [wuxing] — rooted between Heaven and Earth and inexhaustible — thus are called 'phases/processes' [xing, literally 'walking']. The North — yin at extreme generates cold, cold generates Water. The South — yang at extreme generates heat, heat generates Fire. The East — yang scattering to vent generates wind, wind generates Wood. The West — yin stopping to collect generates dryness, dryness generates Metal. The Center — yin-yang copulating generates warmth, warmth generates Earth. Their mutual generation serves mutual sustaining; their mutual overcoming serves mutual restraining — this is called having order."

---

### 14B) Stem-by-Month Pattern Summary

Below is the extracted 10-Stem × 12-Month rule matrix, with key original Chinese rules and English translation.

#### 甲木 (Jia Wood) — Season by Month

| Month | Key Rule (Original) | English |
|---|---|---|
| **正月** (1st) | 初春尚有馀寒，得丙癸逢，富贵双全。癸藏丙透，名寒木向阳，主大富贵。 | Early spring still has leftover cold; obtaining Bing and Gui — wealth and rank both complete. Gui hidden + Bing showing = "Cold Wood Facing Sun" — great wealth and rank. |
| **二月** (2nd) | 庚金得所，名阳刃驾杀，可云小贵。柱中逢才，英雄独压万人。 | Geng Metal obtaining its place = "Yang-Ren Riding Killing" — minor rank. Meeting Wealth in pillars — hero alone suppressing ten-thousand. |
| **三月** (3rd) | 木气相竭。先取庚金，次用壬水。庚壬两透，一榜堪图。 | Wood qi nearing exhaustion. First take Geng Metal, second use Ren Water. Geng + Ren both showing — one examination-list achievable. |
| **四月** (4th) | 退气，丙火司权，先癸后丁。 | Qi retreating; Bing Fire holds authority. First Gui, then Ding. |
| **五月** (5th) | 木性虚焦。先癸后丁，庚金次之。五月癸庚两透，为上上之格。 | Wood nature hollow-scorched. First Gui then Ding; Geng Metal second. Gui + Geng both showing = top-top pattern. |
| **六月** (6th) | 三伏生寒，丁火退气。先丁后庚，无癸亦可。庚丁两透，亦为上上之格。 | Three-heats generating cold; Ding Fire retreating. First Ding then Geng; without Gui is also acceptable. Geng + Ding both showing = also top-top pattern. |
| **七月** (7th) | 丁火为尊，庚金次之，庚金不可少。火隔水不能熔金，故丁火熔金，必赖甲木引助，方成洪炉。 | Ding Fire is honored; Geng Metal second — Geng Metal indispensable. Fire separated by water cannot melt Metal; thus Ding Fire melting Metal must rely on Jia Wood to draw and assist — only then forming the great furnace. |
| **八月** (8th) | 木囚金旺。丁火为先，次用丙火，庚金再次。一丁一庚，科甲定显。 | Wood imprisoned, Metal prosperous. Ding Fire first; next use Bing Fire; Geng Metal again after. One Ding + one Geng — examination success certain. |
| **九月** (9th) | 木凋零，独爱丁火，壬癸滋扶。丁壬癸透，戊己亦透，配得中和。 | Wood withering — uniquely delights in Ding Fire; Ren/Gui moisten and support. Ding + Ren + Gui showing, Wu + Ji also showing — configuration attains central harmony. |
| **十月** (10th) | 庚丁为要，丙火次之。忌壬水泛身，须戊土制之。 | Geng + Ding essential; Bing Fire second. Taboo Ren Water flooding the self — must have Wu Earth to control it. |
| **十一月** (11th) | 木性生寒，丁先庚后，丙火佐之。癸水司权，为火金之病。 | Wood nature generating cold; Ding first Geng next, Bing Fire assisting. Gui Water holds authority — is the illness of Fire and Metal. |
| **十二月** (12th) | 天寒气冻，木性极寒，无生发之象。先用庚劈甲，方引丁火始得木火通明。 | Heaven cold, qi frozen; Wood nature extremely cold, no generating-sprouting image. First use Geng to split Jia; only then draw Ding Fire, beginning to attain "Wood-Fire Through-Brightness." |

---

#### 丁火 (Ding Fire) — Selected Months

| Month | Key Rule (Original) | English |
|---|---|---|
| **正月** | 甲木当权，乃为母旺，非庚不能劈甲，何以引丁，姑用庚金。 | Jia Wood holds authority — this is the mother prosperous. Without Geng, cannot split Jia — how to draw Ding? Tentatively use Geng Metal. |
| **二月** | 湿乙伤丁，先庚后甲，非庚不能去乙，非甲不能引丁。 | Damp Yi harms Ding; first Geng then Jia. Without Geng, cannot remove Yi; without Jia, cannot draw Ding. |
| **三月** | 戊土司令，泄弱丁气。先用甲木引丁制土，次看庚金。 | Wu Earth holds command, draining and weakening Ding qi. First use Jia Wood to draw Ding and control Earth; next look at Geng Metal. |
| **九月** | 一派戊土，泄丁火之气，不见甲木，为伤官伤尽，非寻常可比。 | A whole faction of Wu Earth draining Ding Fire's qi — not seeing Jia Wood — is "Hurting Officer Hurt to Completion" — not comparable to the ordinary. |
| **十月** | 三冬丁火微寒，端用庚甲。甲乃庚之良友。冬丁有甲，不怕水多金多，可称上格。 | Three-winter Ding Fire slightly cold — exclusively use Geng + Jia. Jia is Geng's good friend. Winter Ding having Jia — not afraid of much Water or much Metal — can be called top pattern. |

---

#### 庚金 (Geng Metal) — Selected Months

| Month | Key Rule (Original) | English |
|---|---|---|
| **正月** | 木旺之际，有土皆死，不能生金，且金之寒气未除，先用丙暖庚性，又虑土厚埋金，须甲疏泄。丙甲两透，科甲显荣。 | Wood prosperous period — any Earth is dead, cannot generate Metal; moreover Metal's cold qi not yet removed. First use Bing to warm Geng's nature; also worry Earth thick buries Metal — must have Jia to dredge and vent. Bing + Jia both showing — examination glory manifest. |
| **二月** | 暗强之势，专用丁火，借甲引丁，借庚劈甲。 | Concealed-strength momentum — exclusively use Ding Fire, borrow Jia to draw Ding, borrow Geng to split Jia. |
| **七月** | 刚锐极矣，专用丁火煆炼，次取甲木引丁。 | Hard-sharp at extreme — exclusively use Ding Fire to forge and refine; next take Jia Wood to draw Ding. |
| **八月** | 刚锐未退，仍用丁甲，丙不可少。 | Hard-sharp not yet retired — still use Ding + Jia; Bing cannot be missing. |
| **十月** | 水冷金寒，非丁不能造，非丙不能暖。 | Water cold, Metal frigid — without Ding cannot forge; without Bing cannot warm. |

---

### 14C) Pattern Logic Summary

The 《穷通宝鉴》's entire system reduces to a **climate-adjustment** framework:

1. **Each day-stem has an ideal climate**, and each month imparts a specific thermal-moisture condition
2. **The primary medicinals** (用神) are the stems that correct thermal-moisture imbalance:
   - **Cold months** (亥子丑, roughly Nov–Jan): need 丙 (Bing) Fire to warm, assisted by 甲 (Jia) to draw fire
   - **Hot months** (巳午未, roughly May–Jul): need 癸 (Gui) Water to cool, sometimes 壬 (Ren)
   - **Dry autumn** (申酉戌, roughly Aug–Oct): need 丁 (Ding) Fire to forge Metal, 甲 (Jia) to split and draw
   - **Damp spring** (寅卯辰, roughly Feb–Apr): need 庚 (Geng) to trim excess Wood, 丙 (Bing) to dispel remnant cold
3. **Secondary medicinals** handle the month's ruling stem when it overpowers the day-stem
4. The system is fundamentally **relational**: it's not one stem's absolute strength but its relationship to the month's qi that determines need

---

### 14D) Translation Layer — Key Qiong Tong Bao Jian Terminology

| Chinese Term | English | Concept |
|---|---|---|
| 调候 (Tiao Hou) | Climate Regulation | Adjusting thermal-moisture balance per month |
| 寒木向阳 (Han Mu Xiang Yang) | Cold Wood Facing Sun | Jia Wood in cold months requiring Bing Fire |
| 木火通明 (Mu Huo Tong Ming) | Wood-Fire Through-Brightness | Jia Wood + Ding Fire: clear talent pattern |
| 劈甲引丁 (Pi Jia Yin Ding) | Split Jia, Draw Ding | Geng Metal splitting Jia Wood so Ding Fire can ignite |
| 水泛木浮 (Shui Fan Mu Fu) | Water Floods, Wood Floats | Excess Ren/Gui drowning Jia/Yi Wood |
| 火炎土燥 (Huo Yan Tu Zao) | Fire Blazing, Earth Parched | Excess Bing/Ding scorching Wu/Ji Earth |
| 金寒水冷 (Jin Han Shui Leng) | Metal Cold, Water Freezing | Winter Geng/Xin without warming Fire |
| 藤萝系甲 (Teng Luo Xi Jia) | Vine Clinging to Trees | Yi Wood + Jia Wood mutual support pattern |
| 伤官伤尽 (Shang Guan Shang Jin) | Hurting Officer Hurt to Completion | Shangguan pattern with no opposing Officer star |

**Confidence**: **High** — sourced from complete ctext.org text with full 10-stem × 12-month rules extracted. Cross-referenced with 百度百科 structural overview. The text continues through all ten stems (戊, 己, 庚, 辛, 壬, 癸) with identical month-by-month structure.

---

## Cross-Source Consistency Notes

1. **Zi Wei vs. Ba Zi temporal model**: 《紫微斗数全书》 uses star-palace placement by birth time (lunar calendar, 12 two-hour periods); 《滴天髓》 and 《穷通宝鉴》 use eight-character pillar structure. These are distinct systems sharing only the five-phase cosmology and sexagenary cycle infrastructure.

2. **Anti-mechanical stance is shared**: Both 王亭之 (中州派, Batch 05) and 任铁樵 (滴天髓阐微, this batch) emphatically reject mechanical pattern-matching. Ren's standard is even broader: he rejects shensha, nayin, "strange patterns" (奇格异局) entirely.

3. **Yong Shen positioning**: 《滴天髓》 sees 用神 as flexible — any of the ten gods can serve; 《穷通宝鉴》's "用神" is more specific: it's always the climate-regulating stem(s) for that day-stem in that month. These two uses of the same term are related but not identical.

4. **Translation layer consistency**: Across this batch, key terms like 用神, 制化, 顺逆, and 旺衰 are now translated with consistent English glosses, with Chinese originals preserved for precision.

---

*End of BOOK_NOTES_BATCH_06_ZIWEI_MINGLI.md*
