# frozen_string_literal: true
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Figaro.env.aws_access_key_id,
    aws_secret_access_key: Figaro.env.aws_secret_access_key,
    region:                'eu-central-1'
  }
  config.fog_directory  = 'rkotov93-spa-bucket' # required
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.days.to_i}" } # optional, defaults to {}
end
