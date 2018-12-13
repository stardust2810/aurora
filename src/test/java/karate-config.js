function() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  karate.configure("ssl", true)

  if (!env) {
    env = 'dev'; //env can be anything: dev, qa, staging, etc.
  }
  var config = {
    env: env,

    APEX_REALM: 'http://apex_l2_eg',
    APP_ID: 'apex_l2_eg_app_id',
    APP_ID_VALUE: 'edh-5iLlRCGWvZ94ysTfulcy4H1W',
    APEX_SIGNATURE_METHOD: 'SHA256withRSA',
    APEX_VERSION: '1.0',
    APP_SECRET: 'fc09eb269e6655dafc6414645a10884afdccf0ee',
  };

  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}