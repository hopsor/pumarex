import Elm from './main';

const elmDiv = document.getElementById('app')

if (elmDiv) {
  const initialSessionData = localStorage.getItem('sessionData');
  const sessionData = initialSessionData ? JSON.parse(initialSessionData) : null;
  const app = Elm.Main.embed(elmDiv, {sessionData: sessionData});

  app.ports.storeSessionData.subscribe((sessionData) => {
    localStorage.setItem('sessionData', JSON.stringify(sessionData));
  });

  app.ports.destroySessionData.subscribe(() => {
    localStorage.removeItem('sessionData');
  });
}
