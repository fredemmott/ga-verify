task :default => :thrift

task :thrift => ['gen-rb/ga-verify_types.rb'] do
end

file 'gen-rb/ga-verify_types.rb' => 'if/ga-verify.thrift' do
  sh "thrift --gen rb if/ga-verify.thrift"
end
