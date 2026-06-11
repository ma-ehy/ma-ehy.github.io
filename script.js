// GLOBAL STATE
let currentSeason = 0;
let playersList = [];
let filteredPlayers = [];
let leaderboardData = [];
let leaderboardLoaded = 10;
let leaderboardTotal = 0;
let selectedVersion = null;
let selectedMode = null;
let currentPlayerId = null;
let modesData = null;

const API_BASE = 'https://ranked.maehy.aninternettroll.xyz';

// Hardcoded fallback names
const KNOWN_PLAYERS = {
  "1319828319449124914": "〆ken",
  "1007008336832626728": "Firsttryflint",
  "561612126611832833": "Râmbø",
  "662772697557762058": "crazdenuy",
  "1372329612754812988": "Raimu",
  "1294578223820181556": "Flashtick_54",
  "1421929499334807654": "BlockBuster127",
  "1443933315584360448": "YudonRannus",
  "900078975475392514": "Elliot",
  "1413685262508097597": "Golden",
  "882555111119913030": "?¿Hoxha¿?",
  "1496787469671337996": "MICROPER MC",
  "1170353911018831872": "Ananr123",
  "1333609219005350039": "Noopless",
  "1476894133619785728": "Youhun",
    "1513255074346832111": "Jollepr0\ud83d\udca5",
  "1371434730091974767": "mistah",
  "1401232108118216847": "Nuvro",
  "1264027393673138242": "Uwais",
  "1352307448177754154": "\u0741\u22c6\u2b52\u02da.\u22c6 \ud835\udcd4\ud835\udcf5\ud835\udcf8\ud835\udced\ud835\udcf2\ud835\udcee\u0741 \u22c6\u2b52\u02da.\u22c6",
  "1480014656868319242": "Happyambot",
  "1190617707956154482": "Nate",
  "1138204430102183937": "Night",
  "1266991614858104944": "Shrava7n",
  "1389654350481064027": "\u2022\ud835\udc36\u210e\ud835\udc5f\ud835\udc5c\ud835\udc5a\ud835\udc52\u2022",
  "717854796559941683": "Tadeo",
  "1490463284170588320": "RNLD26",
  "665713676870746132": "dinonuggieboi",
  "919384576382623744": "chicken died",
  "1440456818567549062": "IAmCool1062",
  "1307444068309012503": "Equinox",
  "1197897384622039063": "Niek.N",
  "1398460773344477306": "PandaNyx",
  "1505963328978161744": "Akshat",
  "1447375261120069714": "PheonixGaming",
  "767613353639804938": "Quantum_Cube",
  "1452004998991839335": "Tortillaguy",
  "1152739756476735498": "Lost",
  "1291538539221225574": "Sweekie",
  "1160379275707428965": "kayla",
  "786579087694495805": "Taha",
  "818972183857594469": "timfrmdap",
  "1294076838527893606": "smile203happy",
  "1300569570322550864": "Dylanfurey",
  "1062411728849223861": "Frameful",
  "1456541191939031078": "Johnstansmuffins",
  "1251077215404429320": "Juzar",
  "1036944834851782678": "BB",
  "1316399287592026162": "Striker_Strike",
  "1199567132086779944": "Coal",
  "990605263214108672": "IronPickaxe",
  "1340078827010789428": "Ryan",
  "1409161890302529659": "Pro574389",
  "1172324569885966466": "\ud835\ude56\ud835\ude57\ud835\ude64\ud835\ude59\ud835\ude6e \ud835\ude57\ud835\ude68/.Bs_456799",
  "878436827571290124": "seif1",
  "1472980141897420862": "lucy.797",
  "1351984938517397585": "Visa Torkkeli",
  "1473469570676297738": "Charlie757556",
  "1384646569407549603": "Omakun\ud83d\udc66\ud83c\udfff",
  "530759358942937088": "Loaded",
  "1391798179229597726": "Showsharp",
  "1183015533180895259": "Crypto_noob",
  "1301647525899665504": "Anthony martial",
  "514547225326649345": "tragos",
  "1417266876857454634": "atensivecream",
  "1403891517948694650": "Vadex",
  "1301281157043720307": "deleted_user_8589626414ff",
  "1486538406614925334": "yusefwa",
  "1250236651028877384": "Jazzzzzz.",
  "1486766621291708537": "Fpser",
  "1440090465105088593": "RobockiHere",
  "1503386826583441479": "The Diesel Freak",
  "1208996117157515278": "QwicklishMC",
  "713459496629960805": "Dragonninja1298",
  "1377015111117705452": "survivirmine 2.0",
  "1325783386622525493": "Indeedrisk",
  "1410916807035850782": "Phyro\ud83d\udcd6\ud83e\udd13",
  "1406744848714694766": "Kasu025playyys",
  "1190052094204448891": "PlaneWarrior59",
  "880005807796781056": ".void",
  "1288793247338205275": "Tilted Potato",
  "1392779105342193694": "soaplordmc",
  "1353362410878271533": "deleted_user_99f9882c19db",
  "1031072799390965862": "faze rug",
  "1491282177013321819": "busy_unicorn_81069",
  "882221243137400892": "worst1",
  "1398004834312917083": "Hitssuua",
  "536681523244433418": "Cubex_K",
  "1477896808343666719": "KUNAAAAAL",
  "1469022921119760525": "mrpurplecheetah",
  "1420174941650944025": "elliONK",
  "906566794825830430": "Yuvix",
  "1329859217691115587": "MONGREL",
  "678682483222380604": "hashbrown",
  "819021570558656542": "Chicken_Nugget",
  "1232906544534782064": "Najish786",
  "1383851800901451839": "Kihonneko72",
  "1065059628783779841": "iris",
  "1262913294327349330": "Rjbeast",
  "1337817659403800647": "Seth",
  "756382205923557387": "Arrow",
  "1464618576127197244": "AvGeek",
  "1378713493192179935": "\u29fc\u1d21\u1d00\u0280\u0274\u0303\u1d07\u0280\ud80c\udd89\u29fd",
  "948647885380141086": "Mii Adam",
  "1005245912018333798": "lily",
  "1431691081904554027": "rsv",
  "1392409372465954876": "Kuugacuyy",
  "1457165501917560977": "HarryJMyers",
  "787124313789562900": "melody!!",
  "1416494390406545501": "Jaykeycakey",
  "1456647420183052574": "Shreyash",
  "1473811021344014406": "Mobile15",
  "1347682191907491880": "JoZ",
  "372806659854303245": "wwwwwwwww",
  "1417065431650537563": "deleted_user_38d33466be73",
  "1436409282517139477": "madz",
  "709312982378872892": "pineappleman",
  "675591394823503877": "Tyger2k",
  "859834656312786956": "Sameem",
  "652323283630555138": "thedumdum399",
  "1322534107875639307": "\u2c63\u03c5\u2118\u2118\u0258\u0166\ud83d\udc51",
  "1229360881499111498": "Ishaan",
  "1054536338076082207": "Pocial J",
  "1041722167391436851": "SteadyWatermelon",
  "1300482967109636206": "\ud835\udc40\ud835\udc5c\ud835\udcb8\ud835\udcbd\ud835\udcbe\ud835\udc45\ud835\udc5c",
  "1459350268884815932": "Dambrokkkkt",
  "1247892566683160718": "[LW] Jacek Sokolov",
  "383845949593616385": "ceins",
  "1135014996946985000": "Camry1643",
  "667198758626263047": "mcjiuli",
  "1402657680451178507": "OOOOFY",
  "976012759554736170": "Flush",
  "1437039540169871443": "avan1sh",
  "1341006157762003005": "Trindade",
  "864544353098530866": "Soggybacon",
  "1439248763611906078": "\u219c( \u2022\u0300\u1d17\u2022\u0301 )  /ItzSwift._.X2  \u05b9  \u208a",
  "872127890303627294": "H4510",
  "653290943897927680": "Toby",
  "1345153937527013396": "Roronoa_Gojo (Cart Arc)",
  "1248031254155366593": "Tm_deepwoken void",
  "1451833954314485887": "Buiesvarut",
  "1447173443085664296": "Wowamsogood",
  "1206719935506681926": "Frowst\u00ed",
  "722381245501276180": "Nosty",
  "508735879058161665": "CheffryGotaBlick",
  "1354969343364173995": "weexx",
  "1316356537010229268": "jial",
  "1371433292166856827": "JusDmann",
  "947790189386936381": "Smooth",
  "238046177256407040": "Davomono",
  "776790775932911677": "Harsh",
  "852447975116505118": "Coni",
  "1471807500348297216": "Gressyitalian",
  "1331519370609954918": "Anshuman",
  "1222257629020164186": "yusef",
  "189167787363532809": "skylarr",
  "1460547993324228713": "Englishapoon",
  "1111987904131117057": "Fmotionowl",
  "1366454169623330826": "Izumi Miyamura",
  "862192514283208734": "M8use",
  "1239059050671636551": "snrou",
  "1243875076953346080": "m\u00e3rs.",
  "1303249614362640455": "Anna",
  "1102987777332748339": "Leo",
  "1131590728447971409": "Sharon",
  "513136462129004545": "Traye",
  "1369994658599534704": "\u30da\u30f3\u30ae\u30f3\ud83d\udc27",
  "1084858231467294771": "\u307d\u3093\u9aa8",
  "1196174169524670574": "PeterFromThePaceStore",
  "752822006516547616": "Total",
  "724668431793651742": "AlxBot",
  "1442908245751631873": "\u9c7c\u5b50\u9171",
  "1327403793658282015": "FlopSetz_\u2744",
  "936633999642746970": "Muntazir",
  "1414768997852778496": "M&m",
  "663349775541993474": "LHS1219",
  "943171429350907934": "Dragonix",
  "1448889721710182491": "wangshu_x",
  "1453993107753271310": "xgszw",
  "1257541162777182322": "meynima",
  "1252670589374562356": "Dinoduw",
  "1449754106188267582": "united_eagle_05190",
  "1241628330990768220": "ZynonXmc"
};

// Cache for player stats API calls: id -> data
const statsCache = new Map();

// Resolve a display name for a given Discord ID
function resolveName(id) {
  const fromMap = userNameMap.get(id);
  if (fromMap && fromMap !== 'Player') return fromMap;
  const fromHardcoded = KNOWN_PLAYERS[id];
  if (fromHardcoded) return fromHardcoded;
  return null; // unknown
}

// LOAD STATIC SEASON 0 DATA
function loadStaticSeasonData() {
  if (!window.SEASON0_STATS || !window.SEASON0_ELO_HISTORY) {
    console.warn('Season 0 static data not found. Stats tab will be empty.');
    return;
  }

  const statsData = window.SEASON0_STATS;
  const historyData = window.SEASON0_ELO_HISTORY;

  playersList = [];
  for (const [discordId, stats] of Object.entries(statsData)) {
    if (stats.total_games === undefined || stats.total_games === 0) continue;

    let currentElo = 1000;
    let eloHistory = historyData[discordId] || [];
    if (eloHistory.length > 0) {
      eloHistory.sort((a, b) => a.timestamp - b.timestamp);
      currentElo = eloHistory[eloHistory.length - 1].elo;
    }

    const totalGames = stats.total_games;
    const wins = stats.wins || 0;
    const losses = stats.losses || 0;
    const draws = stats.draws || 0;
    const winRate = totalGames > 0 ? ((wins / totalGames) * 100).toFixed(1) : '0';

    const displayName = resolveName(discordId) || `Unknown#${discordId.slice(-4)}`;

    const player = {
      id: discordId,
      name: displayName,
      discordId: discordId,
      elo: currentElo,
      peakElo: stats.peak_elo || currentElo,
      wins,
      losses,
      draws,
      gamesPlayed: totalGames,
      winRate,
      avatarLetter: displayName.charAt(0).toUpperCase(),
      by_mode: stats.by_mode || {},
      completion_times: stats.completion_times || [],
      head_to_head: stats.head_to_head || {}
    };

    playersList.push(player);
  }

  playersList.sort((a, b) => b.elo - a.elo);
  playersList.forEach((p, idx) => p.rank = idx + 1);
  filteredPlayers = [...playersList];
}

// API CALLS

let userNameMap = new Map();

async function loadUserNames() {
  try {
    const data = await apiCall(`/api/leaderboard?limit=100`);
    for (const entry of (data.leaderboard || [])) {
      if (entry.user && entry.user.id) {
        const name = entry.user.display_name || entry.user.name;
        if (name && name !== 'Player') userNameMap.set(entry.user.id, name);
      }
    }
    console.log(`Loaded ${userNameMap.size} usernames`);
  } catch (err) {
    console.warn('Could not load usernames:', err);
  }
}

async function apiCall(endpoint, options = {}) {
  const url = `${API_BASE}${endpoint}`;
  const headers = options.body ? { 'Content-Type': 'application/json' } : {};
  const response = await fetch(url, { headers, ...options });
  if (!response.ok) throw new Error(`API error: ${response.status}`);
  return response.json();
}

async function fetchOverview() {
  const data = await apiCall('/api/overview');
  return {
    totalPlayers: data.total_players || 0,
    activePlayers: data.active_players || 0,
    totalGames: data.total_games || 0
  };
}

async function fetchLeaderboard(limit = 10) {
  const data = await apiCall(`/api/leaderboard?limit=${limit}`);
  leaderboardTotal = data.total_players || 0;
  return data.leaderboard || [];
}

async function fetchPlayerStats(userId) {
  if (statsCache.has(userId)) return statsCache.get(userId);
  const data = await apiCall(`/api/stats/${userId}`);
  statsCache.set(userId, data);
  return data;
}

async function fetchPlayerMatches(userId, page = 1, perPage = 50) {
  return await apiCall(`/api/matches/${userId}?page=${page}&per_page=${perPage}`);
}

async function fetchModes() {
  return await apiCall('/api/modes');
}

async function fetchSoloSeed(version, mode) {
  return await apiCall('/api/solo', {
    method: 'POST',
    body: JSON.stringify({ version, mode })
  });
}

// HOME / QUICK STATS
async function updateQuickStats() {
  try {
    const stats = await fetchOverview();
    document.getElementById('qs-total').textContent = stats.totalPlayers;
    document.getElementById('qs-active').textContent = stats.activePlayers;
    document.getElementById('qs-games').textContent = stats.totalGames;
  } catch (err) {
    console.error('Failed to load overview:', err);
    document.getElementById('qs-total').textContent = '?';
    document.getElementById('qs-active').textContent = '?';
    document.getElementById('qs-games').textContent = '?';
  }
}

// LEADERBOARD
async function renderLeaderboard() {
  const container = document.getElementById('lb-list');
  const scrollY = window.scrollY; // save scroll position before re-render
  container.innerHTML = '<div class="loader"></div>';

  try {
    leaderboardData = await fetchLeaderboard(leaderboardLoaded);
    leaderboardData = leaderboardData.filter(entry => {
      const games = (entry.wins || 0) + (entry.losses || 0);
      return games >= 5;
    });
    if (leaderboardData.length === 0) {
      container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted);">No players found</div>';
      return;
    }

    container.innerHTML = leaderboardData.map(entry => {
      const player = entry.user;
      const rank = entry.rank;
      const elo = entry.elo;
      const wins = entry.wins || 0;
      const losses = entry.losses || 0;
      const dataRank = rank <= 3 ? `data-rank="${rank}"` : '';
      const tier = getTier(elo);

      // Resolve name: API name -> hardcoded -> fallback
      const apiName = player.display_name || player.name;
      const resolvedName = (apiName && apiName !== 'Player')
        ? apiName
        : (KNOWN_PLAYERS[player.id] || `Unknown#${player.id.slice(-4)}`);

      return `
        <div class="lb-row" ${dataRank} onclick="openPlayerPanel('${player.id}', 'leaderboard')">
          <div class="lb-rank ${getRankClass(rank)}">#${rank}</div>
          <div class="lb-info">
            <div class="lb-name">${escapeHtml(resolvedName)}</div>
            <div class="lb-sub">${wins}W · ${losses}L</div>
          </div>
          <div style="text-align:right;flex-shrink:0;display:flex;flex-direction:column;align-items:flex-end;gap:4px;">
            <div class="lb-elo">${elo}</div>
            <div class="tier-badge" style="background:${tier.bg};color:${tier.color};border:1px solid ${tier.color}40;">${tier.emoji} ${tier.name}</div>
          </div>
        </div>
      `;
    }).join('');

    document.getElementById('lb-badge').textContent = `TOP ${leaderboardData.length}`;

    // Restore scroll position after render
    window.scrollTo(0, scrollY);
  } catch (err) {
    console.error('Leaderboard error:', err);
    container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted);">Failed to load leaderboard</div>';
  }
}

function loadMoreLeaderboard() {
  leaderboardLoaded += 10;
  renderLeaderboard();
}

function getRankClass(rank) {
  if (rank === 1) return 'rank-1';
  if (rank === 2) return 'rank-2';
  if (rank === 3) return 'rank-3';
  return 'rank-other';
}

function getTier(elo) {
  if (elo >= 2000) return { name: 'EGapple',    emoji: '🟣', color: '#A855F7', bg: 'rgba(168,85,247,0.15)' };
  if (elo >= 1900) return { name: 'Gapple III', emoji: '🟡', color: '#FFD700', bg: 'rgba(255,215,0,0.12)' };
  if (elo >= 1800) return { name: 'Gapple II',  emoji: '🟡', color: '#EAB308', bg: 'rgba(234,179,8,0.12)' };
  if (elo >= 1700) return { name: 'Gapple I',   emoji: '🟡', color: '#CA8A04', bg: 'rgba(202,138,4,0.12)' };
  if (elo >= 1600) return { name: 'Bread III',  emoji: '🟫', color: '#D97706', bg: 'rgba(217,119,6,0.12)' };
  if (elo >= 1500) return { name: 'Bread II',   emoji: '🟫', color: '#B45309', bg: 'rgba(180,83,9,0.12)' };
  if (elo >= 1400) return { name: 'Bread I',    emoji: '🟫', color: '#92400E', bg: 'rgba(146,64,14,0.12)' };
  if (elo >= 1300) return { name: 'Apple III',  emoji: '🔴', color: '#EF4444', bg: 'rgba(239,68,68,0.12)' };
  if (elo >= 1200) return { name: 'Apple II',   emoji: '🔴', color: '#DC2626', bg: 'rgba(220,38,38,0.12)' };
  if (elo >= 1100) return { name: 'Apple I',    emoji: '🔴', color: '#B91C1C', bg: 'rgba(185,28,28,0.12)' };
  if (elo >= 1000) return { name: 'Carrot III', emoji: '🟠', color: '#F97316', bg: 'rgba(249,115,22,0.12)' };
  if (elo >= 900)  return { name: 'Carrot II',  emoji: '🟠', color: '#EA580C', bg: 'rgba(234,88,12,0.12)' };
  if (elo >= 800)  return { name: 'Carrot I',   emoji: '🟠', color: '#C2410C', bg: 'rgba(194,65,12,0.12)' };
  if (elo >= 700)  return { name: 'Melon III',  emoji: '🟢', color: '#22C55E', bg: 'rgba(34,197,94,0.12)' };
  if (elo >= 600)  return { name: 'Melon II',   emoji: '🟢', color: '#16A34A', bg: 'rgba(22,163,74,0.12)' };
  if (elo >= 500)  return { name: 'Melon I',    emoji: '🟢', color: '#15803D', bg: 'rgba(21,128,61,0.12)' };
  return             { name: 'Potato',      emoji: '🥔', color: '#78716C', bg: 'rgba(120,113,108,0.12)' };
}

// STATS TAB
function renderStatsList() {
  const container = document.getElementById('stats-list');
  const countSpan = document.getElementById('player-count');

  if (filteredPlayers.length === 0) {
    container.innerHTML = '<div style="text-align: center; padding: 40px; color: var(--muted);">No players found</div>';
    countSpan.textContent = '0 players';
    return;
  }

  countSpan.textContent = `${filteredPlayers.length} players`;

  container.innerHTML = filteredPlayers.map(player => {
    const tier = getTier(player.elo);
    return `
      <div class="stats-row" onclick="openPlayerPanel('${player.id}', 'stats')">
        <div class="stats-rank-num">${player.rank}</div>
        <div class="stats-info">
          <div class="stats-name">${escapeHtml(player.name)}</div>
          <div class="stats-sub">
            <span class="tier-badge" style="background:${tier.bg};color:${tier.color};border:1px solid ${tier.color}40;font-size:11px;padding:2px 7px;">${tier.emoji} ${tier.name}</span>
          </div>
        </div>
        <div class="stats-elo-col">
          <div class="stats-elo-val">${player.elo}</div>
          <div class="stats-elo-lbl">ELO</div>
        </div>
      </div>
    `;
  }).join('');
}

function filterStats() {
  const searchTerm = document.getElementById('stats-search').value.toLowerCase().trim();
  const clearBtn = document.getElementById('stats-clear');

  if (searchTerm === '') {
    filteredPlayers = [...playersList];
    clearBtn.style.display = 'none';
  } else {
    filteredPlayers = playersList.filter(p =>
      p.name.toLowerCase().includes(searchTerm) ||
      p.discordId.toLowerCase().includes(searchTerm)
    );
    clearBtn.style.display = 'flex';
  }
  renderStatsList();
}

function clearSearch() {
  document.getElementById('stats-search').value = '';
  filterStats();
}

function selectSeason(season) {
  currentSeason = season;
  document.querySelectorAll('.season-chip').forEach((chip, idx) => {
    if (idx === season) chip.classList.add('active');
    else chip.classList.remove('active');
  });
}

// PLAYER PANEL
async function openPlayerPanel(playerId, source) {
  currentPlayerId = playerId;
  const panelContent = document.getElementById('panel-content');
  panelContent.innerHTML = '<div class="loader"></div>';
  document.getElementById('panel-overlay').classList.add('open');
  document.getElementById('player-panel').classList.add('open');

  const histBtn = document.getElementById('full-stats-btn');
  if (histBtn) histBtn.style.display = (source === 'leaderboard') ? '' : 'none';

  if (source === 'stats') {
    openPlayerPanelStatic(playerId);
  } else {
    openPlayerPanelAPI(playerId);
  }
}

function openPlayerPanelStatic(playerId) {
  const player = playersList.find(p => p.id === playerId);
  if (!player) {
    document.getElementById('panel-content').innerHTML = '<div style="padding:20px;text-align:center;color:var(--muted)">Player not found in static data</div>';
    return;
  }

  const historyData = window.SEASON0_ELO_HISTORY || {};
  const eloHistory = (historyData[playerId] || []).sort((a, b) => a.timestamp - b.timestamp);
  const tier = getTier(player.elo);
  const modeStatsHtml = buildModeStatsHtml(player.by_mode || {});
  const recentMatchesHtml = buildRecentMatchesHtml(eloHistory);

  document.getElementById('panel-content').innerHTML = `
    <div class="panel-hero">
      <div class="panel-name">${escapeHtml(player.name)}</div>
      <div class="tier-badge-lg" style="background:${tier.bg};color:${tier.color};border:1px solid ${tier.color}40;">${tier.emoji} ${tier.name}</div>
    </div>

    <div class="panel-section">
      <div class="panel-section-title">ELO RATING</div>
      <div class="elo-big">
        <div class="elo-num">${player.elo}</div>
        <div class="elo-peak">Peak<br><span>${player.peakElo}</span></div>
      </div>
      <div class="elo-chart-wrap">
        <canvas id="elo-chart"></canvas>
        <div class="elo-tooltip" id="elo-tooltip"></div>
      </div>
    </div>

    <div class="panel-section">
      <div class="panel-section-title">OVERALL STATS</div>
      <div class="panel-stat-grid">
        <div class="panel-stat-cell"><div class="panel-stat-cell-val green">${player.wins}</div><div class="panel-stat-cell-lbl">Wins</div></div>
        <div class="panel-stat-cell"><div class="panel-stat-cell-val red">${player.losses}</div><div class="panel-stat-cell-lbl">Losses</div></div>
        <div class="panel-stat-cell"><div class="panel-stat-cell-val yellow">${player.draws}</div><div class="panel-stat-cell-lbl">Draws</div></div>
        <div class="panel-stat-cell"><div class="panel-stat-cell-val purple">${player.winRate}%</div><div class="panel-stat-cell-lbl">Win Rate</div></div>
        <div class="panel-stat-cell"><div class="panel-stat-cell-val cyan">${player.gamesPlayed}</div><div class="panel-stat-cell-lbl">Games</div></div>
        <div class="panel-stat-cell"><div class="panel-stat-cell-val">#${player.rank}</div><div class="panel-stat-cell-lbl">Rank</div></div>
      </div>
    </div>

    <div class="panel-section">
      <div class="panel-section-title">MODE STATS</div>
      ${modeStatsHtml}
    </div>

    <div class="panel-section">
      <div class="panel-section-title">RECENT ELO CHANGES</div>
      ${recentMatchesHtml}
    </div>
  `;

  setTimeout(() => drawEloChart(eloHistory), 100);
}

async function openPlayerPanelAPI(playerId) {
  const panelContent = document.getElementById('panel-content');
  try {
    const stats = await fetchPlayerStats(playerId);
    const user = stats.user;
    const elo = stats.elo;
    const peakElo = stats.peak_elo;
    const totalGames = stats.total_games;
    const wins = stats.wins;
    const losses = stats.losses;
    const draws = stats.draws;
    const forfeits = stats.forfeits;
    const winRate = stats.win_rate;
    const wlRatio = stats.wl_ratio;
    const avgTime = stats.avg_completion_time;
    const streaks = stats.streaks;
    const modeStats = stats.mode_stats;
    const eloHistory = stats.elo_history || [];

    const tier = getTier(elo);
    const modeStatsHtml = buildModeStatsHtml(modeStats);
    const recentMatchesHtml = buildRecentMatchesHtml(eloHistory);

    // Resolve name with fallback chain
    const apiName = user.display_name || user.name;
    const resolvedName = (apiName && apiName !== 'Player')
      ? apiName
      : (KNOWN_PLAYERS[user.id] || `Unknown#${user.id.slice(-4)}`);

    panelContent.innerHTML = `
      <div class="panel-hero">
        <div class="panel-name">${escapeHtml(resolvedName)}</div>
        <div class="tier-badge-lg" style="background:${tier.bg};color:${tier.color};border:1px solid ${tier.color}40;">${tier.emoji} ${tier.name}</div>
      </div>

      <div class="panel-section">
        <div class="panel-section-title">ELO RATING</div>
        <div class="elo-big">
          <div class="elo-num">${elo}</div>
          <div class="elo-peak">Peak<br><span>${peakElo}</span></div>
        </div>
        <div class="elo-chart-wrap">
          <canvas id="elo-chart"></canvas>
          <div class="elo-tooltip" id="elo-tooltip"></div>
        </div>
      </div>

      <div class="panel-section">
        <div class="panel-section-title">OVERALL STATS</div>
        <div class="panel-stat-grid">
          <div class="panel-stat-cell"><div class="panel-stat-cell-val green">${wins}</div><div class="panel-stat-cell-lbl">Wins</div></div>
          <div class="panel-stat-cell"><div class="panel-stat-cell-val red">${losses}</div><div class="panel-stat-cell-lbl">Losses</div></div>
          <div class="panel-stat-cell"><div class="panel-stat-cell-val yellow">${draws}</div><div class="panel-stat-cell-lbl">Draws</div></div>
          <div class="panel-stat-cell"><div class="panel-stat-cell-val purple">${winRate}%</div><div class="panel-stat-cell-lbl">Win Rate</div></div>
          <div class="panel-stat-cell"><div class="panel-stat-cell-val cyan">${totalGames}</div><div class="panel-stat-cell-lbl">Games</div></div>
          <div class="panel-stat-cell"><div class="panel-stat-cell-val orange">${forfeits}</div><div class="panel-stat-cell-lbl">Forfeits</div></div>
        </div>
        <div class="panel-row">
          <span class="panel-row-label">W/L Ratio</span>
          <span class="panel-row-val">${wlRatio}</span>
        </div>
        <div class="panel-row">
          <span class="panel-row-label">Avg. Completion</span>
          <span class="panel-row-val">${avgTime || 'N/A'}</span>
        </div>
        <div class="panel-row">
          <span class="panel-row-label">Current Streak</span>
          <span class="panel-row-val">${streaks.current_streak > 0 ? streaks.current_streak + ' ' + (streaks.current_streak_type || '') : 'None'}</span>
        </div>
        <div class="panel-row">
          <span class="panel-row-label">Best Win Streak</span>
          <span class="panel-row-val" style="color:var(--green)">${streaks.best_win_streak}</span>
        </div>
        <div class="panel-row">
          <span class="panel-row-label">Worst Loss Streak</span>
          <span class="panel-row-val" style="color:var(--red)">${streaks.best_loss_streak}</span>
        </div>
      </div>

      <div class="panel-section">
        <div class="panel-section-title">MODE STATS</div>
        ${modeStatsHtml}
      </div>

      <div class="panel-section">
        <div class="panel-section-title">RECENT ELO CHANGES</div>
        ${recentMatchesHtml}
      </div>
    `;

    setTimeout(() => drawEloChart(eloHistory), 100);

  } catch (err) {
    console.error('Failed to load player stats:', err);
    panelContent.innerHTML = '<div style="padding:20px;color:var(--muted);text-align:center;">Failed to load player data</div>';
  }
}

function buildModeStatsHtml(modeStats) {
  return Object.entries(modeStats || {})
    .map(([modeKey, modeData]) => {
      const modeName = modeKey.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
      const wins = modeData.wins || 0;
      const losses = modeData.losses || 0;
      const draws = modeData.draws || 0;
      const total = wins + losses + draws;
      const winPercent = total > 0 ? (wins / total * 100) : 0;
      return `
        <div class="mode-row">
          <div class="mode-row-header">
            <span class="mode-row-name">${escapeHtml(modeName)}</span>
            <span class="mode-row-record">${wins}W - ${losses}L - ${draws}D</span>
          </div>
          <div class="mode-bar-bg">
            <div class="mode-bar-fill" style="width: ${winPercent}%"></div>
          </div>
        </div>
      `;
    }).join('') || '<div class="panel-row"><span class="panel-row-label">No mode data</span></div>';
}

function buildRecentMatchesHtml(eloHistory) {
  const recentHistory = eloHistory.slice(-5).reverse();
  let html = '';
  for (let i = 0; i < recentHistory.length; i++) {
    const entry = recentHistory[i];
    const date = new Date(entry.timestamp * 1000).toLocaleDateString();
    const change = i < recentHistory.length - 1 ? entry.elo - recentHistory[i + 1].elo : 0;
    const changeClass = change > 0 ? 'pos' : (change < 0 ? 'neg' : '');
    const changeSign = change > 0 ? '+' : '';
    const cardClass = change > 0 ? 'win-card' : (change < 0 ? 'loss-card' : 'draw-card');
    html += `
      <div class="match-card ${cardClass}">
        <div class="match-top">
          <span class="match-badge ${change > 0 ? 'win' : (change < 0 ? 'loss' : 'draw')}">
            ${change > 0 ? 'GAIN' : (change < 0 ? 'LOSS' : 'DRAW')}
          </span>
          <span class="match-date">${date}</span>
        </div>
        <div class="match-bottom">
          <div class="match-stat-col">
            <span class="match-stat-lbl">ELO Change</span>
            <span class="match-stat-val ${changeClass}">${changeSign}${change}</span>
          </div>
          <div class="match-stat-col">
            <span class="match-stat-lbl">New ELO</span>
            <span class="match-stat-val">${entry.elo}</span>
          </div>
        </div>
      </div>
    `;
  }
  return html || '<div class="panel-row"><span class="panel-row-label">No recent matches</span></div>';
}

function drawEloChart(history) {
  const canvas = document.getElementById('elo-chart');
  if (!canvas || !history || history.length === 0) return;

  const wrap = canvas.parentElement;
  const tooltip = document.getElementById('elo-tooltip');
  const ctx = canvas.getContext('2d');
  const width = wrap.clientWidth - 28;
  const height = 120;
  canvas.width = width;
  canvas.height = height;

  const elos = history.map(h => h.elo);
  const maxElo = Math.max(...elos);
  const minElo = Math.min(...elos);
  const range = maxElo - minElo || 1;
  const pad = 4;

  function getX(idx) { return idx * (width / Math.max(history.length - 1, 1)); }
  function getY(elo) { return pad + (height - pad * 2) - ((elo - minElo) / range) * (height - pad * 2); }

  function redraw(hoverIdx = -1) {
    ctx.clearRect(0, 0, width, height);

    ctx.beginPath();
    history.forEach((entry, idx) => {
      const x = getX(idx);
      const y = getY(entry.elo);
      if (idx === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    });
    ctx.lineTo(width, height);
    ctx.lineTo(0, height);
    ctx.closePath();
    const gradient = ctx.createLinearGradient(0, 0, 0, height);
    gradient.addColorStop(0, 'rgba(156,39,176,0.35)');
    gradient.addColorStop(1, 'rgba(6,182,212,0.05)');
    ctx.fillStyle = gradient;
    ctx.fill();

    ctx.beginPath();
    ctx.strokeStyle = '#9C27B0';
    ctx.lineWidth = 2.5;
    ctx.lineJoin = 'round';
    history.forEach((entry, idx) => {
      const x = getX(idx);
      const y = getY(entry.elo);
      if (idx === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    });
    ctx.stroke();

    if (hoverIdx >= 0 && hoverIdx < history.length) {
      const x = getX(hoverIdx);
      const y = getY(history[hoverIdx].elo);
      ctx.beginPath();
      ctx.arc(x, y, 5, 0, Math.PI * 2);
      ctx.fillStyle = '#CE93D8';
      ctx.fill();
      ctx.strokeStyle = '#fff';
      ctx.lineWidth = 1.5;
      ctx.stroke();
    }
  }

  redraw();

  canvas.addEventListener('mousemove', (e) => {
    const rect = canvas.getBoundingClientRect();
    const mx = (e.clientX - rect.left) * (width / rect.width);
    const stepX = width / Math.max(history.length - 1, 1);
    const idx = Math.min(Math.round(mx / stepX), history.length - 1);
    redraw(idx);

    const entry = history[idx];
    const date = new Date(entry.timestamp * 1000).toLocaleDateString();
    tooltip.textContent = `${entry.elo} ELO · ${date}`;
    tooltip.style.display = 'block';

    const tx = getX(idx);
    const ty = getY(entry.elo);
    const scaleX = rect.width / width;
    const scaleY = rect.height / height;
    let left = tx * scaleX + 14;
    let top = ty * scaleY - 34;
    if (left + 140 > rect.width) left = tx * scaleX - 145;
    if (top < 0) top = ty * scaleY + 10;
    tooltip.style.left = left + 'px';
    tooltip.style.top = top + 'px';
  });

  canvas.addEventListener('mouseleave', () => {
    redraw(-1);
    tooltip.style.display = 'none';
  });
}

function closePanel() {
  document.getElementById('panel-overlay').classList.remove('open');
  document.getElementById('player-panel').classList.remove('open');
}

async function openFullStats() {
  if (!currentPlayerId) return;
  const modalContent = document.getElementById('fullstats-content');
  modalContent.innerHTML = '<div class="loader"></div>';
  document.getElementById('modal-fullstats').classList.add('open');

  try {
    const matchesData = await fetchPlayerMatches(currentPlayerId, 1, 100);
    const matches = matchesData.matches || [];

    if (matches.length === 0) {
      modalContent.innerHTML = '<div style="padding:20px;text-align:center;">No match history found</div>';
      return;
    }

    modalContent.innerHTML = `
      <div style="max-height:500px;overflow-y:auto;padding:0 16px;">
        ${matches.map(match => {
          const date = new Date(match.timestamp * 1000).toLocaleString();
          const resultClass = match.result === 'win' ? 'win' : (match.result === 'loss' ? 'loss' : 'draw');
          const cardClass = match.result === 'win' ? 'win-card' : (match.result === 'loss' ? 'loss-card' : 'draw-card');
          const changeClass = match.elo_change > 0 ? 'pos' : (match.elo_change < 0 ? 'neg' : '');
          const changeSign = match.elo_change > 0 ? '+' : '';
          return `
            <div class="match-card ${cardClass}" style="margin:8px 0;">
              <div class="match-top">
                <span class="match-badge ${resultClass}">${match.result.toUpperCase()}</span>
                <span class="match-date">${date}</span>
              </div>
              <div class="match-bottom">
                <div class="match-stat-col">
                  <span class="match-stat-lbl">ELO Change</span>
                  <span class="match-stat-val ${changeClass}">${changeSign}${match.elo_change}</span>
                </div>
                <div class="match-stat-col">
                  <span class="match-stat-lbl">New ELO</span>
                  <span class="match-stat-val">${match.new_elo}</span>
                </div>
              </div>
            </div>
          `;
        }).join('')}
      </div>
    `;
  } catch (err) {
    console.error('Failed to load matches:', err);
    modalContent.innerHTML = '<div style="padding:20px;text-align:center;">Failed to load match history</div>';
  }
}

// SOLO TAB
async function loadModes() {
  try {
    modesData = await fetchModes();
  } catch (err) {
    console.error('Failed to load modes:', err);
  }
}

function selectVersion(version) {
  selectedVersion = version;
  selectedMode = null;
  document.getElementById('ver-116').classList.remove('selected');
  document.getElementById('ver-118').classList.remove('selected');
  document.getElementById(`ver-${version}`).classList.add('selected');

  const modeSection = document.getElementById('mode-section');
  if (!modesData) { modeSection.style.display = 'none'; return; }

  const versionData = modesData[version];
  if (!versionData) { modeSection.style.display = 'none'; return; }

  const modes = versionData.modes || [];
  const modeList = document.getElementById('mode-list');
  modeList.innerHTML = modes.map(mode => `
    <button class="mode-btn" onclick="selectMode('${mode.id}')" data-mode="${mode.id}">
      <span class="mode-btn-dot"></span>
      ${escapeHtml(mode.name)}
    </button>
  `).join('');

  modeSection.style.display = 'block';
  document.getElementById('seed-result').style.display = 'none';
}

function selectMode(modeId) {
  selectedMode = modeId;
  document.querySelectorAll('.mode-btn').forEach(btn => {
    btn.classList.remove('selected');
    if (btn.getAttribute('data-mode') === modeId) btn.classList.add('selected');
  });
}

async function getSeed() {
  if (!selectedVersion || !selectedMode) {
    showToast('Please select both version and mode first!');
    return;
  }

  const getSeedBtn = document.getElementById('get-seed-btn');
  getSeedBtn.disabled = true;
  getSeedBtn.textContent = 'LOADING...';

  try {
    const result = await fetchSoloSeed(selectedVersion, selectedMode);
    const rawSeed = String(result.seed || '');
    const seed = rawSeed.includes(',') ? rawSeed.split(',')[0] : rawSeed;

    document.getElementById('seed-mode-label').textContent = result.mode;
    document.getElementById('seed-value').textContent = seed;
    document.getElementById('seed-result').style.display = 'block';
    showToast('Seed generated! Click to copy.');
  } catch (err) {
    console.error('Failed to get seed:', err);
    showToast('Failed to get seed. Please try again.');
  } finally {
    getSeedBtn.disabled = false;
    getSeedBtn.textContent = 'GET SEED';
  }
}

function copySeed() {
  const seedValue = document.getElementById('seed-value').textContent;
  navigator.clipboard.writeText(seedValue);
  showToast(`Copied: ${seedValue}`);
}

// MODALS & TOAST
function openModal(modalId) {
  document.getElementById(modalId).classList.add('open');
}

function closeModal(modalId) {
  document.getElementById(modalId).classList.remove('open');
}

function showToast(message) {
  const toast = document.getElementById('toast');
  toast.textContent = message;
  toast.classList.add('show');
  setTimeout(() => toast.classList.remove('show'), 2000);
}

// TUTORIAL ACCORDIONS
function toggleAccordion(button) {
  const body = button.nextElementSibling;
  button.classList.toggle('open');
  body.classList.toggle('open');
  body.style.maxHeight = body.classList.contains('open') ? body.scrollHeight + 'px' : null;
}

function toggleNested(button) {
  const content = button.nextElementSibling;
  button.classList.toggle('open');
  content.classList.toggle('open');
  content.style.maxHeight = content.classList.contains('open') ? content.scrollHeight + 'px' : null;
}

// TAB SYSTEM
function switchTab(tabId) {
  document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
  document.getElementById(`tab-${tabId}`).classList.add('active');
  document.querySelectorAll('.nav-item').forEach(btn => {
    btn.classList.remove('active');
    if (btn.getAttribute('data-tab') === tabId) btn.classList.add('active');
  });

  if (tabId === 'leaderboard') renderLeaderboard();
  if (tabId === 'stats') renderStatsList();
}

// HELPER
function escapeHtml(str) {
  if (!str) return '';
  return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}

// INIT
document.addEventListener('DOMContentLoaded', async () => {
  await loadUserNames();

  loadStaticSeasonData();
  renderStatsList();

  await updateQuickStats();
  await renderLeaderboard();
  await loadModes();

  document.querySelectorAll('.nav-item').forEach(btn => {
    btn.addEventListener('click', () => switchTab(btn.getAttribute('data-tab')));
  });

  const searchInput = document.getElementById('stats-search');
  if (searchInput) searchInput.addEventListener('input', filterStats);

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      document.querySelectorAll('.modal-overlay.open, .panel-overlay.open').forEach(overlay => overlay.classList.remove('open'));
      document.getElementById('player-panel')?.classList.remove('open');
    }
  });
});

window.switchTab = switchTab;
window.selectVersion = selectVersion;
window.selectMode = selectMode;
window.getSeed = getSeed;
window.copySeed = copySeed;
window.loadMoreLeaderboard = loadMoreLeaderboard;
window.selectSeason = selectSeason;
window.filterStats = filterStats;
window.clearSearch = clearSearch;
window.openPlayerPanel = openPlayerPanel;
window.closePanel = closePanel;
window.openFullStats = openFullStats;
window.openModal = openModal;
window.closeModal = closeModal;
window.toggleAccordion = toggleAccordion;
window.toggleNested = toggleNested;
