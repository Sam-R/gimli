# encoding: utf-8

require './spec/spec_helper'

require './lib/gimli'

describe Gimli::Wkhtmltopdf do

  it 'should assemble correct command' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new
    mock(wkhtmltopdf).bin { 'wkhtmltopdf' }
    args = wkhtmltopdf.command('test.pdf')
    args.size.should == 4
    args.should include '"wkhtmltopdf"'
    args.should include '"--quiet"'
    args.should include '"-"'
    args.should include  '"test.pdf"'
  end

  it 'should assemble correct command with options' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new({:toc => true, :footer_right => '[page]/[toPage]'})
    mock(wkhtmltopdf).bin { 'wkhtmltopdf' }
    args = wkhtmltopdf.command('test.pdf')
    args.size.should == 7
    args.should include '"--toc"'
    args.should include '"--footer-right"'
    args.should include '"[page]/[toPage]"'
  end

  it 'should normalize argument' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new
    wkhtmltopdf.normalize_argument('A b').should == 'a-b'
  end

  it 'should normalize value with string' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new
    wkhtmltopdf.normalize_value('Foo').should == 'Foo'
  end

  it 'should normalize value with true' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new
    wkhtmltopdf.normalize_value(true).should == nil
  end

  it 'should normalize a hash' do
    wkhtmltopdf = Gimli::Wkhtmltopdf.new
    hash = {:foo => true, :bar => nil, :foobar => 'foo'}
    expected = {'--foo' => nil, '--foobar' => 'foo'}
    wkhtmltopdf.normalize_options(hash).should == expected
  end

end
