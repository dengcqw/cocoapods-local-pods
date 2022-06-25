require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Pods do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ pods }).should.be.instance_of Command::Pods
      end
    end
  end
end

