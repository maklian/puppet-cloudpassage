require 'spec_helper'

describe 'cloudpassage' do
  let(:params) {{'apikey' => 'dummykey'}}

  platforms = {
    'Debian'      => {
      'osfamily'  => 'Debian',
      'lsbdistid' => 'Debian',
    },
    'Ubuntu'      => {
      'osfamily'  => 'Debian',
      'lsbdistid' => 'Ubuntu',
    },
    'RedHat'     => {
      'osfamily' => 'RedHat',
    },
    'CentOS'     => {
      'osfamily' => 'RedHat',
    },
  }

  platforms.each_pair do |os, facts|
    describe "on #{os}" do
      let(:facts) {{ :operatingsystem => os }.merge(facts) }

      it { should contain_class('cloudpassage::install').that_notifies('cloudpassage::config') }
      it { should contain_class('cloudpassage::config').that_notifies('cloudpassage::service') }
      it { should contain_class('cloudpassage::service') }

      describe 'cloudpassage::install' do
        it { should contain_package('cphalo') }
      end

      describe 'cloudpassage::config' do
        it {
          should contain_exec('initialize cloudpassage').with(
            "command"     => "/opt/cloudpassage/bin/configure --api-key=dummykey --tag=#{os}",
            "refreshonly" => "true"
          )
        }
      end

      describe 'cloudpassage::service' do
        it { should contain_service('cphalod').with_enable('true') }
      end
    end
  end

  describe 'configuring repositories' do
    platforms.select { |k, v| v['osfamily'] == 'RedHat'}.each_pair do |os, facts|
      describe "on the RedHat like platform #{os}" do
        let(:facts) {{ :operatingsystem => os }.merge(facts) }

        it {
          should contain_yumrepo('cloudpassage').with(
            'descr'    => 'CloudPassage production',
            'baseurl'  => "http://packages.cloudpassage.com/redhat/\$basearch",
            'gpgcheck' => 1,
            'gpgkey'   => 'https://packages.cloudpassage.com/cloudpassage.packages.key'
          )
        }
      end
    end

    platforms.select { |k, v| v['osfamily'] == 'Debian'}.each_pair do |os, facts|
      describe "on the Debian like platform #{os}" do
        let(:facts) {{ :operatingsystem => os }.merge(facts) }

        it {
          should contain_apt__source('cloudpassage').with(
            'ensure'   => 'present',
            'key'      => {
              'source' => 'https://packages.cloudpassage.com/cloudpassage.packages.key',
              'id'     => '29AF0E02ACF0366976105511013FE82585F4BB98',
            },
            'location' => 'http://packages.cloudpassage.com/debian',
            'release'  => 'debian',
            'repos'    => 'main',
          )
        }
      end
    end
  end
end
