fs = require 'fs-extra'
path = require 'path'
_ = require 'lodash'
walk = require 'walkdir'
androidAssetPress = require './assetpress-android'
iOSAssetPress = require './assetpress-ios'

module.exports = (options) ->

  defaults = 
    cwd: process.cwd()
    inputDirectoryName: 'source'
    outputDirectoryName: false
    verbose: false
    clean: false
    os: 'ios'
    androidLdpi: false
    androidXxxhdpi: false
    iosMinimumUniversal: 1
    iosMaximumUniversal: 3
    iosMinimumPhone: 2
    iosMaximumPhone: 3
    iosMinimumPad: 1
    iosMaximumPad: 2
    iosXcassets: false
  options = _.defaults options, defaults

  cwd = options.cwd
  cwd += '/' if cwd.slice(-1) != '/'

  inputDirectory = path.join cwd, options.inputDirectoryName
  inputDirectory += '/' if inputDirectory.slice(-1) != '/'
  return process.stdout.write "Input directory #{ inputDirectory } does not exist." if !fs.existsSync inputDirectory
    
  androidOptions = 
    ldpi: options.androidLdpi
    xxxhdpi: options.androidXxxhdpi

  iosOptions = 
    minimumUniversal: parseInt options.iosMinimumUniversal
    maximumUniversal: parseInt options.iosMaximumUniversal
    minimumPhone: parseInt options.iosMinimumPhone
    maximumPhone: parseInt options.iosMaximumPhone
    minimumPad: parseInt options.iosMinimumPad
    maximumPad: parseInt options.iosMaximumPad
    xcassets: options.iosXcassets

  globalOptions = 
    cwd: cwd
    verbose: options.verbose
    clean: options.clean
    outputDirectoryName: options.outputDirectoryName

  switch options.os
    when 'android'
      androidAssetPress inputDirectory, androidOptions, globalOptions
    when 'ios'
      iOSAssetPress inputDirectory, iosOptions, globalOptions
