"use strict";(("undefined"!=typeof self?self:global).webpackChunkclient_web=("undefined"!=typeof self?self:global).webpackChunkclient_web||[]).push([[6923],{43730:(t,e,o)=>{o.r(e),o.d(e,{AllShowSponsors:()=>f,default:()=>h});var s=o(50959),n=o(5311),r=o(38762),a=o(26922),c=o(57543),i=o(78447),u=o(38700),d=o(11527);const l=(0,s.lazy)((()=>Promise.all([o.e(1814),o.e(569)]).then(o.bind(o,40569))));function f(t){const{showId:e=""}=(0,n.UO)(),o=(0,s.useMemo)((()=>(0,r.xt)(e).toURI()),[e]),{location:{state:{showSponsorsData:f}={}}}=(0,i.P)(),{showSponsorsData:h}=(0,u.O)({showId:e,showSponsorsData:f});return h?.length?(0,d.jsx)(l,{uri:o,showId:e,showSponsorsData:h,...t}):(0,d.jsx)(a.InstrumentedRedirect,{to:(0,c.mH)(e)})}const h=f},16089:(t,e,o)=>{o.d(e,{F:()=>a,m:()=>c});var s=o(50959),n=o(49857),r=o(32714);const a=420;function c({episodeBase62Id:t,getEpisodeSponsors:e,fetchedEpisodeSponsorsData:c=[],version:i}){const[u,d]=(0,s.useState)(c),l=(0,s.useCallback)((async()=>{try{if(!t)throw new Error("episodeBase62Id is required to fetch episode sponsors");const s=e??(await Promise.resolve().then(o.bind(o,50076))).getEpisodeSponsors;d(await s(t,{version:i}))}catch(t){d([])}}),[t,e,i]),f=(0,n.y1)(l,a);(0,s.useEffect)((function(){c.length||f()}),[f,c.length]);const h=(0,s.useCallback)((()=>({effectCallback:f})),[f]);return(0,r.H)(h),{fetchedEpisodeSponsorsData:u}}},38700:(t,e,o)=>{o.d(e,{O:()=>c});var s=o(50959),n=o(49857),r=o(16089),a=o(32714);function c({showId:t,showSponsorsData:e=[],getShowSponsors:c}){const[i,u]=(0,s.useState)(e),d=(0,s.useCallback)((async e=>{const s=(...t)=>{e.mounted&&u(...t)};try{if(!t)throw new Error("showId is required to fetch show sponsors");const e=c??(await Promise.resolve().then(o.bind(o,35769))).getShowSponsors;s(await e(t))}catch(t){s([])}}),[t,c]),l=(0,n.y1)(d,r.F);(0,s.useEffect)((function(){const t={mounted:!0};return e.length||l(t),()=>{t.mounted=!1}}),[l,e.length]);const f=(0,s.useCallback)((()=>{const t={mounted:!0};return{effectCallback(){l(t)},destructor(){t.mounted=!1}}}),[l]);return(0,a.H)(f),{showSponsorsData:i}}},32714:(t,e,o)=>{o.d(e,{H:()=>u});var s=o(50959),n=o(58665),r=o(74818),a=o(62129),c=o(28106),i=o(6215);function u(t){const e=(0,n.W6)(r.oFA),o=(0,c.Y)((t=>{const e=t?.item??void 0;return(0,i.k6)(e)&&e.isPodcastAd?e.id??void 0:void 0})),u=(0,a.D)(o);(0,s.useEffect)((function(){const{effectCallback:s,destructor:n}=t();return o!==u&&Boolean(o)&&setTimeout(s,e),n}),[t,o,u,e])}},78447:(t,e,o)=>{o.d(e,{P:()=>c});var s=o(50959),n=o(92878);let r;const a=!1;function c(){const t=(0,n.D)(),{listen:e,location:o}=t;return a&&(r=o.state),(0,s.useEffect)((function(){return e(((t,e)=>{"POP"===e&&(t.state={...a?Object(r):void 0,...o.state,...t.state})}))})),t}}}]);
//# sourceMappingURL=xpui-routes-all-show-sponsors.js.map