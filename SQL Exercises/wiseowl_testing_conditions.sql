create PROCEDURE uspInformation
@word varchar(max)
AS
BEGIN
    if(@word = 'Event')
     select EventName,EventDate,EventDetails
     from tblEvent
    else if(@word = 'Country')
     select CountryName
     from tblCountry 
    else if(@word = 'Continent')
     select ContinentName
     from tblContinent
    else select 'Nuh uh say the mgic word'='You must enter : Event,Country or Continent'  
END

EXECUTE uspInformation 'Event'
EXECUTE uspInformation 'Country'
EXECUTE uspInformation 'Continent'
EXECUTE uspInformation 'kdfgs'
