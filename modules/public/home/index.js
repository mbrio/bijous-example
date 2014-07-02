window.onload = function () {
  var request = new XMLHttpRequest();
  request.open('GET', '/hello');
  request.send(null);
  request.onreadystatechange = function() {
    var msg = document.getElementById('message');

    if (request.readyState === 4) {
      var json = JSON.parse(request.response);

      for (var key in json.hello) {
        if (json.hello.hasOwnProperty(key)) {
          msg.innerText = 'The API said \'' + json.hello[key] + '\' in (' + key + ')';
          break;
        }
      }
    } else {
      msg.innerText = 'An error has occurred.'
    }
  };
};