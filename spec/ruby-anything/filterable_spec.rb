# -*- coding: utf-8 -*-

require 'spec_helper'

describe RubyAnything::Filterable do
  describe '#filter' do
    [
      [ 'foo', 'hoge', 'foobar' ]
    ].each do |ary|
      context "when self is #{ary}" do
        let(:filtarable) { ary.extend(described_class) }

        context "when given 'foo'" do
          subject { filtarable.filter 'foo' }
          it { should eq([ 'foo', 'foobar' ]) }
        end
        context "when given 'bar'" do
          subject { filtarable.filter 'bar' }
          it { should eq([ 'foobar' ]) }
        end

        context "when given 'ho'" do
          subject { filtarable.filter 'ho' }
          it { should eq([ 'hoge' ]) }
        end
      end
    end
  end
end
