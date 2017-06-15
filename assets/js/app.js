import Elm from './main';

const elmDiv = document.getElementById('app')

if (elmDiv) {
  const initialSessionData = localStorage.getItem('sessionData');
  const sessionData = initialSessionData ? JSON.parse(initialSessionData) : null;
  const loggedIn = initialSessionData ? true : false;
  const app = Elm.Main.embed(elmDiv, {sessionData: sessionData, loggedIn: loggedIn});

  app.ports.storeSessionData.subscribe((sessionData) => {
    localStorage.setItem('sessionData', JSON.stringify(sessionData));
  });

  app.ports.destroySessionData.subscribe(() => {
    localStorage.removeItem('sessionData');
  });
}
