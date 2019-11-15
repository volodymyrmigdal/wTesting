( function _Electron_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  require( '../tester/MainTop.s' );

  _.include( 'wFiles' );

  var ElectronPath = require( 'electron' );
  var Spectron = require( 'spectron' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;
  self.tempDir = _.path.pathDirTempOpen( _.path.join( __dirname, '../..'  ), 'Tester' );
  self.assetDirPath = _.path.join( __dirname, '_asset' );
}

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.tempDir, 'Tester' ) )
  _.path.pathDirTempClose( self.tempDir );
}

// --
// tests
// --

function html( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'electron' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let mainPath = _.path.nativize( _.path.join( routinePath, 'main.js' ) );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  let app = new Spectron.Application
  ({
    path : ElectronPath,
    args : [ mainPath ]
  })

  let ready = app.start()

  .then( () => app.client.waitUntilTextExists( 'p','Hello world', 5000 ) )

  .then( () =>
  {
    test.case = 'Check element text'
    return app.client.$( '.class1 p' ).getText()
    .then( ( got ) =>
    {
      test.identical( got, 'Text1' )
    })
  })

  .then( () =>
  {
    test.case = 'Check href attribute'
    return app.client.$( '.class1 a' ).getAttribute( 'href')
    .then( ( got ) =>
    {
      test.is( _.strEnds( got, '/index.html' ) )
    })
  })

  .then( () =>
  {
    test.case = 'Check input field value'
    return app.client.getValue( '#input1' )
    .then( ( got ) =>
    {
      test.identical( got, '123' )
    })
  })

  .then( () =>
  {
    test.case = 'Change input field value and check it'
    return app.client
    .$( '#input1' )
    .setValue( '321' )
    .getValue( '#input1' )
    .then( ( got ) =>
    {
      test.identical( got, '321' )
    })
  })

  .then( () => app.stop() )

  return _.Consequence.From( ready );
}

//

async function htmlAwait( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'electron' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let mainPath = _.path.nativize( _.path.join( routinePath, 'main.js' ) );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  let app = new Spectron.Application
  ({
    path : ElectronPath,
    args : [ mainPath ]
  })

  await app.start()
  await app.client.waitUntilTextExists( 'p','Hello world', 5000 )

  test.case = 'Check element text'
  var got = await app.client.$( '.class1 p' ).getText();
  test.identical( got, 'Text1' )

  test.case = 'Check href attribute'
  var got = await app.client.$( '.class1 a' ).getAttribute( 'href');
  test.is( _.strEnds( got, '/index.html' ) )

  test.case = 'Check input field value'
  var got = await app.client.getValue( '#input1' );
  test.identical( got, '123' )

  test.case = 'Change input field value and check it'
  await app.client.$( '#input1' ).setValue( '321' )
  var got = await app.client.getValue( '#input1' )
  test.identical( got, '321' )

  await app.stop();

  return null;
}

//

function consequenceFromExperiment( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'electron' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let mainPath = _.path.nativize( _.path.join( routinePath, 'main.js' ) );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  let app = new Spectron.Application
  ({
    path : ElectronPath,
    args : [ mainPath ],
  })

  let ready = app.start();

  test.is( _.promiseIs( ready ) );

  ready.then( () => app.client.waitUntilTextExists( 'p', 'Hello world', 5000 ) )

  ready = _.Consequence.From( ready );

  ready.then( () => _.Consequence.From( app.client.getValue( '#input1' ) ) ) /* returns promiseLike object */

  ready.then( ( got ) =>
  {
    test.case = 'input field value expected, but not object';

    debugger;
    console.log( 'promiseIs:', _.promiseIs( got ) )
    console.log( 'promiseLike:', _.promiseLike( got ) )
    console.log( 'typeof:', typeof got )
    console.log( 'has then routine:', _.routineIs( got.then ) )
    console.log( 'has catch routine:', _.routineIs( got.catch ) )

    test.identical( got, '123' )
    return got;
  })

  ready.then( () =>_.Consequence.From( app.stop() ) )

  return ready;
}

consequenceFromExperiment.experimental = 1;

//

function chaining()
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'electron' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let mainPath = _.path.nativize( _.path.join( routinePath, 'main.js' ) );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  let app = new Spectron.Application
  ({
    path : ElectronPath,
    args : [ mainPath ]
  })

  let ready = app.start()

  .then( () => app.client.waitUntilTextExists( 'p','Hello world', 5000 ) )

  //select command is chained with .getText

  .then( () => app.client.$( '.class1 p' ).getProperty( 'innerText' ) )

  .then( ( text ) =>
  {
    console.log( text )
    return null;
  })

  return _.Consequence.From( ready );
}

// --
// suite
// --
debugger
var Self =
{

  name : 'Tools.atop.Tester.Electron',
  silencing : 1,
  enabled : 0,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,
  routineTimeOut : 300000,

  context :
  {
    tempDir : null,
    assetDirPath : null,
  },

  tests :
  {
    html,
    htmlAwait,
    consequenceFromExperiment,
    chaining
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();