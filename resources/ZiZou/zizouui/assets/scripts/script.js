const progressCells = document.querySelectorAll('.progress-item');

const changeProgress = (percents) => {
  const loadLineElement = document.querySelector('.loadLine');
  const loadElement = document.querySelector('.loadBG');

  if (loadLineElement) {
    loadLineElement.style.setProperty('--percents', `"${Math.round(percents)}%"`);
  }

  if (loadElement) {
    loadElement.style.setProperty('--width', `${Math.round(percents)}%`);
  }

  document.getElementById('stageloading').innerText = loadingStages[currentLoadingStage] + '...';

};


var currentLoadingStage = 0;
var loadingWeights = [1.5 / 10, 4 / 10, 1.5 / 10, 3 / 10];
const loadingStages = [
  "Pré-chargement",
  "Chargement de GtaCity",
  "Initialisation",
  "Chargement de votre personnage",
];

const technicalNames = [
  "INIT_BEFORE_MAP_LOADED",
  "MAP",
  "INIT_AFTER_MAP_LOADED",
  "INIT_SESSION",
];

var loadingTotals = [70, 70, 70, 300];
var registeredTotals = [0, 0, 0, 0];
var stageVisible = [false, false, false, false];

var currentProgress = [0.0, 0.0, 0.0, 0.0];
var currentProgressSum = 0.0;
var currentLoadingCount = 0;

function doProgress(stage) {
  var idx = technicalNames.indexOf(stage);
  if (idx >= 0) {
    registeredTotals[idx]++;
    if (idx > currentLoadingStage) {
      while (currentLoadingStage < idx) {
        currentProgress[currentLoadingStage] = 1.0;
        currentLoadingStage++;
      }
      currentLoadingCount = 1;
    } else currentLoadingCount++;
    currentProgress[currentLoadingStage] = Math.min(
      currentLoadingCount / loadingTotals[idx],
      1.0
    );
    updateProgress();
  }
}

const totalWidth = 99.1;
var progressMaxLengths = [];
var updated = 0
var updatedStages = []
var updatedAStage = false
var lastProgress = 0

var i = 0;
while (i < currentProgress.length) {
  progressMaxLengths[i] = loadingWeights[i] * totalWidth;
  i++;
}

function updateProgress()
{
  var i = 0;
  if (currentLoadingStage == 3 && !updatedAStage) {
    updatedAStage = true
    console.log('stared')
    setTimeout(updateFakeProgress, 3500)
  }
  while(i <= currentLoadingStage)
  {
        if (currentProgress[i] !== lastProgress && !updatedStages[currentLoadingStage]) {
          var newprog = 0
          currentProgress.forEach(element => {
            newprog = newprog += element
          });
          newprog = newprog*progressMaxLengths[i]
          lastProgress = newprog
          updatedStages[currentLoadingStage] = true
          changeProgress(newprog)
        }
        i++;
  }
}
updateProgress();

function updateFakeProgress() {
  if (lastProgress <= 99.0) {
    lastProgress = lastProgress + 1
    changeProgress(lastProgress)
    setTimeout(updateFakeProgress, 330)
  }
}

var count = 0;
const gstate = {
  elems: [],
  log: [],
};

function printLog(type, str) {
  gstate.log.push({ type: type, str: str });
}

Array.prototype.last = function () {
  return this[this.length - 1];
};

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

const handlers = {
  startInitFunction(data) {
    gstate.elems.push({
      name: data.type,
      orders: [],
    });

    if (data.type) doProgress(data.type);
  },
  startInitFunctionOrder(data) {

    count = data.count;
    if (data.type) doProgress(data.type);
  },

  initFunctionInvoking(data) {
    if (data.type) doProgress(data.type);
  },

  initFunctionInvoked(data) {
    if (data.type) doProgress(data.type);
  },

  endInitFunction(data) {
    if (data.type) doProgress(data.type);
  },

  startDataFileEntries(data) {
    count = data.count;

    if (data.type) doProgress(data.type);
  },

  onDataFileEntry(data) {
    doProgress(data.type);
    if (data.type) doProgress(data.type);
  },

  endDataFileEntries() {
  },

  performMapLoadFunction(data) {
    doProgress("MAP");
  },

  onLogLine(data) {
  },
};
window.addEventListener("message", function (e) {
  const data = e.data;
  if (handlers[data.eventName]) handlers[data.eventName](data);
});

if (!window.invokeNative) {
  var newType = function newType(name) {
    return function () {
      return handlers.startInitFunction({ type: name });
    };
  };
  var newOrder = function newOrder(name, idx, count) {
    return function () {
      return handlers.startInitFunctionOrder({
        type: name,
        order: idx,
        count: count,
      });
    };
  };
  var newInvoke = function newInvoke(name, func, i) {
    return function () {
      handlers.initFunctionInvoking({ type: name, name: func, idx: i });
      handlers.initFunctionInvoked({ type: name });
    };
  };
  var startEntries = function startEntries(count) {
    return function () {
      return handlers.startDataFileEntries({ count: count });
    };
  };
  var addEntry = function addEntry() {
    return function () {
      return handlers.onDataFileEntry({ name: "meow", isNew: true });
    };
  };
  var stopEntries = function stopEntries() {
    return function () {
      return handlers.endDataFileEntries({});
    };
  };

  var newTypeWithOrder = function newTypeWithOrder(name, count) {
    return function () {
      newType(name)();
      newOrder(name, 1, count)();
    };
  };

  const demoFuncs = [
    newTypeWithOrder("MAP", 5),
    newInvoke("MAP", "meow1", 1),
    newInvoke("MAP", "meow2", 2),
    newInvoke("MAP", "meow3", 3),
    newInvoke("MAP", "meow4", 4),
    newInvoke("MAP", "meow5", 5),
    newOrder("MAP", 2, 2),
    newInvoke("MAP", "meow1", 1),
    newInvoke("MAP", "meow2", 2),
    startEntries(6),
    addEntry(),
    addEntry(),
    addEntry(),
    addEntry(),
    addEntry(),
    addEntry(),
    stopEntries(),
    newTypeWithOrder("INIT_SESSION", 4),
    newInvoke("INIT_SESSION", "meow1", 1),
    newInvoke("INIT_SESSION", "meow2", 2),
    newInvoke("INIT_SESSION", "meow3", 3),
    newInvoke("INIT_SESSION", "meow4", 4),
  ];

  setInterval(function () {
    demoFuncs.length && demoFuncs.shift()();
  }, 350);
}

function rangeAffect(value) {
  myAudio.volume = value
  document.getElementById("volume-slider").value = value
  if (value > 0.5) {
    document.getElementById("volume-icon").src = "./assets/images/volume-loud.png";
  } else if (value == 0) {
    document.getElementById("volume-icon").src = "./assets/images/volume-mute.png";
  } else {
    document.getElementById("volume-icon").src = "./assets/images/volume-low.png";
  }
}

let play = true;
const myAudio = document.getElementById("music");
myAudio.volume = 0.1;
rangeAffect(0.1)

window.focus();
