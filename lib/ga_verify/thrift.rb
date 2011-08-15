# Copyright 2011-present Fred Emmott. See COPYING file.
module GAVerify
  THRIFT_PATH=File.expand_path(File.join(File.dirname(__FILE__), '/../../gen-rb'))
end

$LOAD_PATH.push(GAVerify::THRIFT_PATH)
require 'verifier'
require 'ga-verify_constants'
require 'ga-verify_types'
$LOAD_PATH.pop
