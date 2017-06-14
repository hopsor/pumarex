import Elm from './main';

const elmDiv = document.getElementById('app')

if (elmDiv) {
  const app = Elm.Main.embed(elmDiv);

  app.ports.storeSessionData.subscribe((sessionData) => {
    localStorage.setItem('sessionData', JSON.stringify(sessionData));
  });
}
