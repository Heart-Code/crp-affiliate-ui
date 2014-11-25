CRP Customer's UI
================
This application contains the UI from a customer's perspective to use the CRP network that's provided by the CRP Web API.

## Install dependencies
Global dependencies:
```
npm install -g gulp
```

Then local dependencies:
```
npm install
```

## Run on development
Run `gulp watch` in order to build the source code and have a live reload server running immediatly. If you have conflicts with using the port 8080 you can do `gulp watch -p <port>` instead.

## Production build
To get a production ready build simply run `gulp build` and you'll get the application ready to use on the `public` folder.