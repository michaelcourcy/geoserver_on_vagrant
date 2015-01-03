require 'spec_helper'

describe 'simple_redhat' do
  let (:facts) { {
    :osfamily => 'RedHat',
  } }

  context 'when versions are not specified' do
    let (:facts) { {
      :augeas_lens_dir     => :undef,
      :augeas_ruby_version => :undef,
      :augeas_version      => :undef,
      :osfamily            => 'RedHat',
    } }

    it { is_expected.to contain_package('augeas').with(
      :ensure => 'present'
    ) }
    it { is_expected.to contain_package('augeas-libs').with(
      :ensure => 'present'
    ) }
    it { is_expected.to contain_package('ruby-augeas').with(
      :ensure => 'present',
      :name   => 'ruby-augeas'
    ) }
  end

  context 'when versions are specified' do
    let (:facts) { {
      :osfamily            => 'RedHat',
      :augeas_lens_dir     => :undef,
      :augeas_version      => '1.2.3',
      :augeas_ruby_version => '3.2.1',
    } }

    it { is_expected.to contain_package('augeas').with(
      :ensure => '1.2.3'
    ) }
    it { is_expected.to contain_package('augeas-libs').with(
      :ensure => '1.2.3'
    ) }
    it { is_expected.to contain_package('ruby-augeas').with(
      :ensure => '3.2.1',
      :name   => 'ruby-augeas'
    ) }
  end

  context 'with standard lens_dir' do
    let (:facts) { {
      :augeas_lens_dir     => :undef,
      :augeas_ruby_version => :undef,
      :augeas_version      => :undef,
      :osfamily            => 'RedHat',
    } }

    it { is_expected.to contain_file('/usr/share/augeas/lenses').with(
      :ensure       => 'directory',
      :purge        => 'true',
      :force        => 'true',
      :recurse      => 'true',
      :recurselimit => 1
    ) }
    it { is_expected.to contain_file('/usr/share/augeas/lenses/dist').with(
      :ensure       => 'directory',
      :purge        => 'false'
    ) }
    it { is_expected.to contain_file('/usr/share/augeas/lenses/tests').with(
      :ensure       => 'directory',
      :purge        => 'true',
      :force        => 'true'
    ).without(:recurse) }
  end

  context 'with a non standard lens_dir' do
    let (:facts) { {
      :augeas_lens_dir     => '/opt/augeas/lenses',
      :augeas_ruby_version => :undef,
      :augeas_version      => :undef,
      :osfamily            => 'RedHat',
    } }

    it { is_expected.to contain_file('/opt/augeas/lenses').with(
      :ensure       => 'directory',
      :purge        => 'true',
      :force        => 'true',
      :recurse      => 'true',
      :recurselimit => 1
    ) }
    it { is_expected.to contain_file('/opt/augeas/lenses/dist').with(
      :ensure       => 'directory',
      :purge        => 'false'
    ) }
    it { is_expected.to contain_file('/opt/augeas/lenses/tests').with(
      :ensure       => 'directory',
      :purge        => 'true',
      :force        => 'true'
    ).without(:recurse) }
  end
end
