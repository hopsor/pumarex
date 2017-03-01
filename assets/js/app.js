import Elm from './main';

const elmDiv = document.getElementById('app')

if (elmDiv) {
  Elm.Main.embed(elmDiv);
}
