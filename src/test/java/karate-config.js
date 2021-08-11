function fn() {
  var env = karate.env; // get system property 'karate.env'
  var config = { env: env }
  var headers = {"cache-control": "no-cache"}
  karate.configure('ssl' , true)
  if (!env) { env = 'uat'; }

  config = karate.read('classpath:services/support/config/domain.yaml')[env]


  karate.log('karate.env system property was:', env);
  karate.configure('headers', headers);
  karate.configure('retry', { count: 10, interval: 5000 });
  return config;
}