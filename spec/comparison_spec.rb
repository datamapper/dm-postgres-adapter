require 'spec_helper'

require 'dm-core/spec/shared/semipublic/query/conditions/abstract_comparison_spec'
require 'dm-postgres-adapter/spec/setup'

describe DataMapper::Query::Conditions::Comparison do
  before :all do
    module ::Blog
      class Article
        include DataMapper::Resource

        property :id,    Serial
        property :title, String, :required => true
      end
    end
    DataMapper.finalize

    @model = Blog::Article
  end

  before :all do
    @property = @model.properties[:id]
  end

  it { DataMapper::Query::Conditions::Comparison.should respond_to(:new) }

  describe '.new' do
    {
      :ilike   => DataMapper::Query::Conditions::ILikeComparison,
    }.each do |slug, klass|
      describe "with a slug #{slug.inspect}" do
        subject { DataMapper::Query::Conditions::Comparison.new(slug, @property, @value) }

        it { should be_kind_of(klass) }
      end
    end

    describe 'with an invalid slug' do
      subject { DataMapper::Query::Conditions::Comparison.new(:invalid, @property, @value) }

      it { method(:subject).should raise_error(ArgumentError, 'No Comparison class for :invalid has been defined') }
    end
  end
end

describe DataMapper::Query::Conditions::ILikeComparison do
  it_should_behave_like 'DataMapper::Query::Conditions::AbstractComparison'

  before do
    @property       = @model.properties[:title]
    @other_property = @model.properties[:id]
    @value          = '_it%'
    @other_value    = 'Other Title'
    @slug           = :ilike
    @comparison     = DataMapper::Query::Conditions::Comparison.new(@slug, @property, @value)
    @other          = OtherComparison.new(@property, @value)
  end

  subject { @comparison }

  it { should respond_to(:inspect) }

  describe '#inspect' do
    subject { @comparison.inspect }

    it { should == '#<DataMapper::Query::Conditions::ILikeComparison @subject=#<DataMapper::Property::String @model=Blog::Article @name=:title> @dumped_value="_it%" @loaded_value="_it%">' }
  end

  it { should respond_to(:matches?) }

  describe '#matches?' do
    supported_by :all do
      describe 'with a matching Hash' do
        subject { @comparison.matches?(@property.field => 'TITLE') }

        it { should be(true) }
      end

      describe 'with a not matching Hash' do
        subject { @comparison.matches?(@property.field => 'Other TITLE') }

        it { should be(false) }
      end

      describe 'with a matching Resource' do
        subject { @comparison.matches?(@model.new(@property => 'TITLE')) }

        it { should be(true) }
      end

      describe 'with a not matching Resource' do
        subject { @comparison.matches?(@model.new(@property => 'Other TITLE')) }

        it { should be(false) }
      end

      describe 'with a not matching nil field' do
        subject { @comparison.matches?(@property.field => nil) }

        it { should be(false) }
      end

      describe 'with a not matching nil attribute' do
        subject { @comparison.matches?(@model.new(@property => nil)) }

        it { should be(false) }
      end
    end
  end

  it { should respond_to(:relationship?) }

  describe '#relationship?' do
    subject { @comparison.relationship? }

    it { should be(false) }
  end

  it { should respond_to(:to_s) }

  describe '#to_s' do
    subject { @comparison.to_s }

    it { should == 'title ILIKE "_it%"' }
  end
end
