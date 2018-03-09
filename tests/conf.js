const reports = require("@testx/reporters-jasmine");

exports.config = {
  SELENIUM_PROMISE_MANAGER: true,
  directConnect: true,
  specs: ["spec/*"],
  capabilities: {
    browserName: "chrome",
    chromeOptions: {
      args: ["--headless", "--disable-gpu", "--window-size=1920,1080"]
    }
  },
  framework: "jasmine2",
  jasmineNodeOpts: {
    silent: true,
    defaultTimeoutInterval: 300000,
    includeStackTrace: false
  },
  baseUrl: "http://localhost:8082",
  onPrepare: () => {
    require("testx");
    testx.objects.add(require("./objects"));
    beforeEach(() => (browser.ignoreSynchronization = true));
    reports();
  }
};
