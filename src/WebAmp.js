
let WebAmp;
let isClosed = false;

document.addEventListener("keydown", evt => {
  if  (evt.key === 'w' && evt.ctrlKey && evt.altKey) {
    if (WebAmp) {
      isClosed && WebAmp.reopen();
      isClosed = false;
      return;
    }
    WebAmp = new window.Webamp({
      zIndex: 9999999,
      initialTracks: [
        {
          metaData: {
            artist: "DJ Mike Llama",
            title: "Llama Whippin' Intro"
          },
          url: "https://cdn.jsdelivr.net/gh/captbaritone/webamp@43434d82cfe0e37286dbbe0666072dc3190a83bc/mp3/llama-2.91.mp3",
          duration: 5.322286
        },
        {
          metaData: {
            artist: "Bensound.com",
            title: "Creative Minds"
          },
          url: "/audio/bensound-creativeminds.mp3",
          duration: 147
        },
        {
          metaData: {
            artist: "Bensound.com",
            title: "Happy Rock"
          },
          url: "/audio/bensound-happyrock.mp3",
          duration: 105
        },
        {
          metaData: {
            artist: "Bensound.com",
            title: "Pop Dance"
          },
          url: "/audio/bensound-popdance.mp3",
          duration: 161
        },
      ],
    });
    WebAmp.renderWhenReady(document.getElementById('webamp'));
    WebAmp.onClose(() => isClosed = true);
  }
});
