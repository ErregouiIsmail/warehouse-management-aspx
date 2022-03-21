const fs = require('fs').promises;
const path = require('path');

const DATA_PATH = path.join(__dirname, 'countries+cities.json');

const USE_DATABASE = `-- Connect to the 'WarehouseManagementSystem' database 
USE WarehouseManagementSystem
GO`;

const COUNTRIES_INSERT_TEMPLATE = `
-- Insert rows into table 'dbo.countries'
INSERT INTO dbo.countries
  ([name], [iso3], [flag])
VALUES
{{values}}
GO
`;
const COUNTRY_INSERT_TEMPLATE = "  ('{{name}}', '{{iso3}}', '{{flag}}')";

const CITIES_INSERT_TEMPLATE = `
-- Insert rows into table 'dbo.cities'
INSERT INTO dbo.cities
  ([name], [country_id])
VALUES
{{values}}
GO
`;
const CITY_INSERT_TEMPLATE = "  ('{{name}}', {{country_id}})";

async function main() {
  console.log('init');

  const rawData = await fs.readFile(DATA_PATH);

  /**
   * @typedef {object} CityData
   * @property {string} name
   */

  /**
   * @typedef {object} CountryData
   * @property {string} name
   * @property {string} iso3
   * @property {string} emoji
   * @property {Array.<CityData>} cities
   */

  /** @type {Array.<CountryData>} */
  const data = JSON.parse(rawData);

  const countries = [];
  const cities = [];
  let i = 0;
  let tmpCities = [];

  data.forEach((country, idx) => {
    const countryLine = COUNTRY_INSERT_TEMPLATE.replace('{{name}}', country.name.replace(/'/g, "''"))
      .replace('{{iso3}}', country.iso3)
      .replace('{{flag}}', country.emoji);

    countries.push(countryLine);

    country.cities.forEach((city) => {
      const cityLine = CITY_INSERT_TEMPLATE.replace('{{name}}', city.name.replace(/'/g, "''")).replace('{{country_id}}', idx + 1);

      if (tmpCities.length === 999) {
        if (!cities[i]) {
          cities[i] = [];
        }
        cities[i].push(...tmpCities);
        i += 1;
        tmpCities = [];
      } else {
        tmpCities.push(cityLine);
      }
    });
  });

  const countriesInsert = COUNTRIES_INSERT_TEMPLATE.replace('{{values}}', countries.join(',\n'));
  const citiesInsert = cities.map((subCities) => CITIES_INSERT_TEMPLATE.replace('{{values}}', subCities.join(', \n')));

  const fileContent = [USE_DATABASE, countriesInsert, ...citiesInsert].join('\n');

  await fs.writeFile(path.join(__dirname, '..', 'database', '002_default_inserts.sql'), fileContent, 'utf-8');

  console.log('done');
}

main().catch(console.error);
