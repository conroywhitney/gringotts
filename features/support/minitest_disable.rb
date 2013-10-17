# remove minitest warning about --profile
# per: https://github.com/cucumber/multi_test/pull/2 
require 'multi_test'
MultiTest.disable_autorun