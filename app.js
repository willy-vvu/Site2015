!function(){"use strict";var e="undefined"!=typeof window?window:global;if("function"!=typeof e.require){var t={},n={},o=function(e,t){return{}.hasOwnProperty.call(e,t)},i=function(e,t){var n,o,i=[];n=/^\.\.?(\/|$)/.test(t)?[e,t].join("/").split("/"):t.split("/");for(var r=0,a=n.length;a>r;r++)o=n[r],".."===o?i.pop():"."!==o&&""!==o&&i.push(o);return i.join("/")},r=function(e){return e.split("/").slice(0,-1).join("/")},a=function(t){return function(n){var o=r(t),a=i(o,n);return e.require(a,t)}},s=function(e,t){var o={id:e,exports:{}};return n[e]=o,t(o.exports,a(e),o),o.exports},u=function(e,r){var a=i(e,".");if(null==r&&(r="/"),o(n,a))return n[a].exports;if(o(t,a))return s(a,t[a]);var u=i(a,"./index");if(o(n,u))return n[u].exports;if(o(t,u))return s(u,t[u]);throw new Error('Cannot find module "'+e+'" from "'+r+'"')},l=function(e,n){if("object"==typeof e)for(var i in e)o(e,i)&&(t[i]=e[i]);else t[e]=n},h=function(){var e=[];for(var n in t)o(t,n)&&e.push(n);return e};e.require=u,e.require.define=l,e.require.register=l,e.require.list=h,e.require.brunch=!0}}(),require.register("content/enviroinvasive/content",function(e,t,n){var o='<p><em>Works best in <a href="https://www.mozilla.org/firefox/">Firefox</a>. Leap Motion is supported.</em></p>\n<p>An interactive info-graphic on the Emerald Ash Borer for AP Environmental Science.</p>\n';"function"==typeof define&&define.amd?define([],function(){return o}):"object"==typeof n&&n&&n.exports&&(n.exports=o)}),require.register("content/essence/content",function(e,t,n){var o="<p>A minimalistic racing game written in Processing in under 5000 bytes for the Kapparate 5K competition</p>\n";"function"==typeof define&&define.amd?define([],function(){return o}):"object"==typeof n&&n&&n.exports&&(n.exports=o)}),require.register("content/gridflow/content",function(e,t,n){var o="<p>A game about managing the power grid and avoiding blackouts!</p>\n<p>I worked on this game during my summer internship at the Concord Consortium.\nScreenshots are of the early prototypes I worked on. Expect the demo to evolve over time.</p>\n";"function"==typeof define&&define.amd?define([],function(){return o}):"object"==typeof n&&n&&n.exports&&(n.exports=o)}),require.register("content/ktbytegrader/content",function(e,t,n){var o="<p>A hackathon-winning project whose playful UI was written by me.</p>\n<p>Kitty Byte Challenge is a Java programming site where you try to solve problems faster than others.\nWe want to make learning Java fun. Also, we want the Java learning experience to be accessible to\nstudents who only have web browsing devices (such as some tablets, phones, school computers). Although\nthere are many online Javascript learning tools, Java is a different language from Javascript. Twenty\nsix thousand high school students take the AP Computer Science exam in Java every year, and many more\ntake Java classes. Additionally, Java is extremely popular in early university computer science programs.\nWe are building this for those students.</p>\n";"function"==typeof define&&define.amd?define([],function(){return o}):"object"==typeof n&&n&&n.exports&&(n.exports=o)}),require.register("content/plasmid/content",function(e,t,n){var o='<p>A concept puzzle game about reversing colorful segments.\nThis is a <a href="http://www.chromeexperiments.com/">Chrome Experiment</a>!</p>\n<p>Written entirely in HTML, CSS, and JavaScript, using nothing but <a href="http://threejs.org/">three.js</a>.</p>\n<p>I started with the desire to create a puzzle game. A game that would challenge the mind in unexpected ways as a departure from contemporary games that don&#39;t require much thought.</p>\n<p>What makes for a great puzzle problem to be solved? First of all, it should be simple. A simple puzzle is easily learned and explained, as well as motivating - solving a simple puzzle shouldn&#39;t be too complex, right? Secondly, it has to have a clear solution. Knowing exactly what you&#39;re looking for is the first step to solving it, providing another layer of clarity and motivation. Lastly, the puzzle needs to be varied and open to multiple methods of solving and puzzle creation.</p>\n<p>With these goals in mind, I was inspired by linked lists and circular arrays. If the array had a clear order, items could be swapped to reestablish the order, similar to sorting. The more I thought about it, the better it seemed. Swapping multiple adjacent items would be like reversing segments. Reversal is varied by it&#39;s non-commutative property, simple in nature, and pairs perfectly with a circular array. I had the beginnings of plasmid.</p>\n<p>Immediately, I began sketching simple levels using lines and numbers. I went through multiple iterations of the logo and various levels before I settled on using colors to denote a sorted order. The more I drew, the more absorbed I became. And so began the development.</p>\n<p>Over the course of a few weeks, a game rose out of a soup of javascript, json, and images. I was unaware of CommonJS at the time, so I lumped all the code into one massive file. I crafted all text in vector graphics, letter by letter, as I had not conceived of a method of easily creating and using entire fonts in 3d. In addition to the messy files was the sub-par user experience. It was unclear what could and could not be clicked, let alone the confusing Campaign label that was essentially &quot;Play&quot; - I had dreamed of multiple play modes. I could have done a much better job, but all is currently in retrospect. The game stands as a proud achievement of a simple creative thought, desire, and determined effort.</p>\n';"function"==typeof define&&define.amd?define([],function(){return o}):"object"==typeof n&&n&&n.exports&&(n.exports=o)}),require.register("main",function(e,t){var n,o,i,r,a,s,u,l,h,c,p;u=t("projects"),s="",l=document.getElementById("projects"),n=document.getElementById("detail"),a=document.getElementById("pages"),h=document.getElementById("quotes"),r=0,h.data=t("quotes"),l.data=u,u.forEach(function(e){return e.content=t("content/"+e.id+"/content")}),i=function(e,t){var i;return i=u.filter(function(t){return t.id===e}),i.length>0?(i=i[0],n.project=i,a.setAttribute("selected",0),a.selected=0,r=o(),t||p($(a).offset().top,300),document.getElementById("quickscroll").id=i.id):(a.setAttribute("selected",1),a.selected=1,t||p(0===r?$(a).offset().top-100:r,300),r=0)},c=function(e){return i(window.location.hash.replace(/[^a-z]/g,""),null==e),e?e.preventDefault():void 0},o=function(){return Math.max($("body").scrollTop(),$("html").scrollTop())},p=function(e,t){return $("html, body").animate({scrollTop:e},t)},$("#comedown core-icon-button").click(function(){return p($(a).offset().top,1e3)}),window.addEventListener("hashchange",c,!0),c()}),require.register("projects",function(e,t,n){n.exports=[{id:"gridflow",name:"Gridflow",date:"July 2014",images:["1.png","2.png","3.png","4.png","5.png"],links:[{text:"View Demo",href:"http://concord-consortium.github.io/gridflow"},{text:"View on Github",href:"https://github.com/concord-consortium/gridflow"},{text:"View on Concord Consortium",href:"http://concord.org"}],tags:["Pixi.js","Firebase","Concord Consortium"]},{id:"plasmid",name:"Plasmid",date:"March 2014",images:["thumb.png","Plasmid2.png","Plasmid3.png"],links:[{text:"Play Now",href:"http://willy-vvu.github.io/plasmid"},{text:"View on Github",href:"http://www.github.com/willy-vvu/plasmid"},{text:"View on Chrome Experiments",href:"http://www.chromeexperiments.com/detail/plasmid"}],tags:["three.js","Mobile","LocalStorage","Offline"]},{id:"enviroinvasive",name:"Invasive Species",date:"February 2014",images:["thumb.png","2.png","3.png"],links:[{text:"View Now",href:"http://willy-vvu.github.io/EnviroInvasiveSpecies"},{text:"View on Github",href:"http://www.github.com/willy-vvu/EnviroInvasiveSpecies"}],tags:["CSS 3D","Leap Motion"]},{id:"essence",name:"Essence",date:"November 2013",images:["thumb.png","Screenshot1.png","Screenshot2.png","Screenshot3.png","Screenshot4.png"],links:[{text:"View on Youtube",href:"https://www.youtube.com/watch?v=zz7cor7WviQ"},{text:"View on Github",href:"http://www.github.com/willy-vvu/essence"},{text:"View on Kapparate",href:"https://www.ktbyte.com/contests/5k2013"}],tags:["Processing","Kapparate"]},{id:"ktbytegrader",name:"KTByte Challenge",date:"October 2013",images:["thumb.png","2.png","3.png","4.png"],links:[{text:"View on Youtube",href:"https://www.youtube.com/watch?v=LWe6fVA7uLU"},{text:"View the Hackathon",href:"https://www.hackerleague.org/hackathons/virtual-hackathon-reforming-education/blogposts"}],tags:["Hackathon","Kapparate"]}]}),require.register("quotes",function(e,t,n){n.exports=["A great question is one that everyone asks, but only a few dare to answer.","Our capabilities are only limited by the limits we impose on ourselves.","An ideal world can never be achieved. That doesn't stop me from trying.","Do what you love, and try to love what you don't.","Some try to forget the past - others try to remember the future.","The future is what you make of it - so go make it awesome!","When inspiration strikes, strike back!","Ideas are hardly in short supply. It's the people who capture them who are.","Learning how to write code is like learning how to write: you can express yourself in ways you never thought were possible.","There's not a single action you make or a single word you say that doesn't reflect who you are. Embrace it.","The only person who can make you a better person is yourself.","We never truly forget - we just fail to remember.","Our identities are able to shape the way we think. Let the way you think shape your identity.","Great thoughts are not meant to be kept inside the head - Express yourself!","Experiment to find your favorite medium: Creativity comes in countless different flavors.","You'll never know if you don't try. You can always try, even if you don't know.","The digital realm is an extraordinary thing: it's a world where in which the unreachable is suddenly tangible.","You can see anything, from what's in front of you to your wildest dreams. All you need to know is where to look.","Time will gladly be on your side if you let it.","Try thinking something no one else has thought before, because no one can think of everything!","Thinking outside the box is only necessary if you box your own thoughts in.","It's hard to imagine how you'll be viewed a century or a millenia from now.","Unique individuals are homogenous, but homogenous individuals are not unique.","Let passion guide you and creativity get you there.","A passionate heart and a creative mind are a potent combination."]});