require 'spec_helper'

describe Smtp2go::Smtp2goBaseException do
  it { expect(described_class).to be Smtp2go::Smtp2goBaseException }
end

describe Smtp2go::Smtp2goAPIKeyException do
  it { expect(described_class).to be < Smtp2go::Smtp2goBaseException }

  it "raises a salient exception message" do
    exception = described_class.new
    expect(exception.message).to include(
      'SMTP2GO_API_KEY', 'Environment Variable')
  end
end

describe Smtp2go::Smtp2goParameterException do
  it { expect(described_class).to be < Smtp2go::Smtp2goBaseException }

  it "raises a salient exception message" do
    exception = described_class.new
    expect(exception.message).to include('html', 'text')
  end
end
