(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';

    if (has(cache, path)) return cache[path].exports;
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex].exports;
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  var list = function() {
    var result = [];
    for (var item in modules) {
      if (has(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.list = list;
  globals.require.brunch = true;
})();
(function() {
  var WebSocket = window.WebSocket || window.MozWebSocket;
  var br = window.brunch = (window.brunch || {});
  var ar = br['auto-reload'] = (br['auto-reload'] || {});
  if (!WebSocket || ar.disabled) return;

  var cacheBuster = function(url){
    var date = Math.round(Date.now() / 1000).toString();
    url = url.replace(/(\&|\\?)cacheBuster=\d*/, '');
    return url + (url.indexOf('?') >= 0 ? '&' : '?') +'cacheBuster=' + date;
  };

  var reloaders = {
    page: function(){
      window.location.reload(true);
    },

    stylesheet: function(){
      [].slice
        .call(document.querySelectorAll('link[rel="stylesheet"]'))
        .filter(function(link){
          return (link != null && link.href != null);
        })
        .forEach(function(link) {
          link.href = cacheBuster(link.href);
        });
    }
  };
  var port = ar.port || 9485;
  var host = br.server || window.location.hostname;

  var connect = function(){
    var connection = new WebSocket('ws://' + host + ':' + port);
    connection.onmessage = function(event){
      if (ar.disabled) return;
      var message = event.data;
      var reloader = reloaders[message] || reloaders.page;
      reloader();
    };
    connection.onerror = function(){
      if (connection.readyState) connection.close();
    };
    connection.onclose = function(){
      window.setTimeout(connect, 1000);
    };
  };
  connect();
})();

require.register("content/enviroinvasivespecies/content", function(exports, require, module) {
var __templateData = "<p><em>Works best in <a href=\"https://www.mozilla.org/firefox/\">Firefox</a>. Leap Motion is supported.</em></p>\n<p>An interactive info-graphic on the Emerald Ash Borer for AP Environmental Science.</p>\n";
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("content/essence/content", function(exports, require, module) {
var __templateData = "<p>A minimalistic racing game written in Processing in under 5000 bytes for the Kapparate 5K competition</p>\n";
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("content/gridflow/content", function(exports, require, module) {
var __templateData = "<p>A game about managing the power grid and avoiding blackouts!</p>\n<p>I worked on this game during my summer internship at the Concord Consortium.\nScreenshots are of the early prototypes I worked on. Expect the demo to evolve over time.</p>\n";
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("content/ktbytegrader/content", function(exports, require, module) {
var __templateData = "<p>A hackathon-winning project whose playful UI was written by me.</p>\n<p>Kitty Byte Challenge is a Java programming site where you try to solve problems faster than others.\nWe want to make learning Java fun. Also, we want the Java learning experience to be accessible to\nstudents who only have web browsing devices (such as some tablets, phones, school computers). Although\nthere are many online Javascript learning tools, Java is a different language from Javascript. Twenty\nsix thousand high school students take the AP Computer Science exam in Java every year, and many more\ntake Java classes. Additionally, Java is extremely popular in early university computer science programs.\nWe are building this for those students.</p>\n";
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("content/plasmid/content", function(exports, require, module) {
var __templateData = "<p>A concept puzzle game about reversing colorful segments.\nThis is a <a href=\"http://www.chromeexperiments.com/\">Chrome Experiment</a>!</p>\n<p>Written entirely in HTML, CSS, and JavaScript, using nothing but <a href=\"http://threejs.org/\">three.js</a>.</p>\n<p>I started with the desire to create a puzzle game. A game that would challenge the mind in unexpected ways as a departure from contemporary games that don&#39;t require much thought.</p>\n<p>What makes for a great puzzle problem to be solved? First of all, it should be simple. A simple puzzle is easily learned and explained, as well as motivating - solving a simple puzzle shouldn&#39;t be too complex, right? Secondly, it has to have a clear solution. Knowing exactly what you&#39;re looking for is the first step to solving it, providing another layer of clarity and motivation. Lastly, the puzzle needs to be varied and open to multiple methods of solving and puzzle creation.</p>\n<p>With these goals in mind, I was inspired by linked lists and circular arrays. If the array had a clear order, items could be swapped to reestablish the order, similar to sorting. The more I thought about it, the better it seemed. Swapping multiple adjacent items would be like reversing segments. Reversal is varied by it&#39;s non-commutative property, simple in nature, and pairs perfectly with a circular array. I had the beginnings of plasmid.</p>\n<p>Immediately, I began sketching simple levels using lines and numbers. I went through multiple iterations of the logo and various levels before I settled on using colors to denote a sorted order. The more I drew, the more absorbed I became. And so began the development.</p>\n<p>Over the course of a few weeks, a game rose out of a soup of javascript, json, and images. I was unaware of CommonJS at the time, so I lumped all the code into one massive file. I crafted all text in vector graphics, letter by letter, as I had not conceived of a method of easily creating and using entire fonts in 3d. In addition to the messy files was the sub-par user experience. It was unclear what could and could not be clicked, let alone the confusing Campaign label that was essentially &quot;Play&quot; - I had dreamed of multiple play modes. I could have done a much better job, but all is currently in retrospect. The game stands as a proud achievement of a simple creative thought, desire, and determined effort.</p>\n";
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("main", function(exports, require, module) {
var detail, loadProject, mainScroll, pages, projectHTML, projectList, projects, quotes, reloadProject, scrollTo;

console.time("Load");

projectList = require("projects");

projectHTML = "";

projects = document.getElementById("projects");

detail = document.getElementById("detail");

pages = document.getElementById("pages");

quotes = document.getElementById("quotes");

mainScroll = 0;

quotes.data = require("quotes");

projects.data = projectList;

projectList.forEach(function(item) {
  return item.content = require("content/" + item.id + "/content");
});

console.timeEnd("Load");

loadProject = function(id, initially) {
  var project;
  project = projectList.filter(function(item) {
    return item.id === id;
  });
  if (project.length > 0) {
    project = project[0];
    detail.project = project;
    pages.setAttribute("selected", 0);
    pages.selected = 0;
    mainScroll = $("body").scrollTop();
    return scrollTo($(pages).offset().top, initially ? 100 : 300);
  } else {
    pages.setAttribute("selected", 1);
    pages.selected = 1;
    if (!initially) {
      scrollTo((mainScroll === 0 ? $(pages).offset().top - 200 : mainScroll), 300);
    }
    return mainScroll = 0;
  }
};

reloadProject = function(event) {
  loadProject(window.location.hash.replace(/[^a-z]/g, ""), event == null);
  if (event) {
    return event.preventDefault();
  }
};

scrollTo = function(position, time) {
  return $("html, body").animate({
    scrollTop: position
  }, time);
};

$("#comedown core-icon-button").click(function() {
  return scrollTo($(pages).offset().top, 1000);
});

window.addEventListener("hashchange", reloadProject, true);

$(document).ready(function() {
  return reloadProject();
});


/*
scrollProjectPictures = () ->
  console.log(pages.selected)
  if pages.selected == 0
     *Do your thing
    pictures = $(detail).find(".images")
    console.log pictures
    clearTimeout(scrollProjectPicturesTimeout)
    scrollProjectPicturesTimeout = setTimeout(scrollProjectPictures, 1000)

inViewOnRight = (image, container) ->
  containerLeft = $(container).scrollLeft()
  containerWidth = $(container).width()
  elemLeft = $(image).offset().left
  elemWidth = $(image).width()
   *0 if not in view, 1 if partially in view, 2 if fully in view
  return containerLeft <= elemLeft
 */
});

;require.register("projects", function(exports, require, module) {
module.exports = [
  {
    id: "gridflow",
    name: "Gridflow",
    date: "July 2014",
    images: ["1.png", "2.png", "3.png", "4.png", "5.png"],
    links: [
      {
        text: "View Demo",
        href: "http://concord-consortium.github.io/gridflow"
      }, {
        text: "View on Github",
        href: "https://github.com/concord-consortium/gridflow"
      }, {
        text: "View on Concord Consortium",
        href: "http://concord.org"
      }
    ],
    tags: ["Pixi.js", "Firebase", "Concord Consortium"]
  }, {
    id: "plasmid",
    name: "Plasmid",
    date: "March 2014",
    images: ["thumb.png", "Plasmid2.png", "Plasmid3.png"],
    links: [
      {
        text: "Play Now",
        href: "http://willy-vvu.github.io/plasmid"
      }, {
        text: "View on Github",
        href: "http://www.github.com/willy-vvu/plasmid"
      }, {
        text: "View on Chrome Experiments",
        href: "http://www.chromeexperiments.com/detail/plasmid"
      }
    ],
    tags: ["three.js", "Mobile", "LocalStorage", "Offline"]
  }, {
    id: "enviroinvasivespecies",
    name: "Invasive Species",
    date: "February 2014",
    images: ["thumb.png", "2.png", "3.png"],
    links: [
      {
        text: "View Now",
        href: "http://willy-vvu.github.io/EnviroInvasiveSpecies"
      }, {
        text: "View on Github",
        href: "http://www.github.com/willy-vvu/EnviroInvasiveSpecies"
      }
    ],
    tags: ["CSS 3D", "Leap Motion"]
  }, {
    id: "essence",
    name: "Essence",
    date: "November 2013",
    images: ["thumb.png", "Screenshot1.png", "Screenshot2.png", "Screenshot3.png", "Screenshot4.png"],
    links: [
      {
        text: "View on Youtube",
        href: "https://www.youtube.com/watch?v=zz7cor7WviQ"
      }, {
        text: "View on Github",
        href: "http://www.github.com/willy-vvu/essence"
      }, {
        text: "View on Kapparate",
        href: "https://www.ktbyte.com/contests/5k2013"
      }
    ],
    tags: ["Processing", "Kapparate"]
  }, {
    id: "ktbytegrader",
    name: "KTByte Challenge",
    date: "October 2013",
    images: ["thumb.png", "2.png", "3.png", "4.png"],
    links: [
      {
        text: "View on Youtube",
        href: "https://www.youtube.com/watch?v=LWe6fVA7uLU"
      }, {
        text: "View the Hackathon",
        href: "https://www.hackerleague.org/hackathons/virtual-hackathon-reforming-education/blogposts"
      }
    ],
    tags: ["Hackathon", "Kapparate"]
  }
];
});

;require.register("quotes", function(exports, require, module) {
module.exports = ["A great question is one that everyone asks, but only a few dare to answer.", "Our capabilities are only limited by the limits we impose on ourselves.", "An ideal world can never be achieved. That doesn't stop me from trying.", "Do what you love, and try to love what you don't.", "Some try to forget the past - others try to remember the future.", "The future is what you make of it - so go make it awesome!", "When inspiration strikes, strike back!", "Ideas are hardly in short supply. It's the people who capture them who are.", "Learning how to write code is like learning how to write: you can express yourself in ways you never thought were possible.", "There's not a single action you make or a single word you say that doesn't reflect who you are. Embrace it.", "The only person who can make you a better person is yourself.", "We never truly forget - we just fail to remember.", "Our identities are able to shape the way we think. Let the way you think shape your identity.", "Great thoughts are not meant to be kept inside the head - Express yourself!", "Experiment to find your favorite medium: Creativity comes in countless different flavors.", "You'll never know if you don't try. You can always try, even if you don't know.", "The digital realm is an extraordinary thing: it's a world where in which the unreachable is suddenly tangible.", "You can see anything, from what's in front of you to your wildest dreams. All you need to know is where to look.", "Time will gladly be on your side if you let it.", "Try thinking something no one else has thought before, because no one can think of everything!", "Thinking outside the box is only necessary if you box your own thoughts in.", "It's hard to imagine how you'll be viewed a century or a millenia from now.", "Unique individuals are homogenous, but homogenous individuals are not unique.", "Let passion guide you and creativity get you there.", "A passionate heart and a creative mind are a potent combination.."];
});

;
//# sourceMappingURL=app.js.map