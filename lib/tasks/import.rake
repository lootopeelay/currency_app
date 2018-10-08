# The rake task to upload the bank excel file into the branch table
namespace :import do
   desc "Import rates from Xml"
   task rates: :environment do 
     RatesHelper.load_rates_from_file
   end
end