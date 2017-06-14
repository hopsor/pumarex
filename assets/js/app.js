import Elm from './main';

const elmDiv = document.getElementById('app')

if (elmDiv) {
  const app = Elm.Main.embed(elmDiv);

  // app.ports.storeJWT.subscribe((jwt) => {
  //
  // });
}
