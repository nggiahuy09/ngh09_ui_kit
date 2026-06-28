/// A country represented in the Finesse UI flag catalog.
///
/// Each case carries an ISO 3166-1 alpha-2 [isoCode] and derives a Unicode
/// flag emoji from it via [flagEmoji].
///
/// ```dart
/// GHCountryFlag(GHCountry.unitedStates)
/// print(GHCountry.france.flagEmoji); // 🇫🇷
/// final country = GHCountry.fromIsoCode('DE'); // GHCountry.germany
/// ```
enum GHCountry {
  /// Afghanistan (AF).
  afghanistan('AF'),

  /// Albania (AL).
  albania('AL'),

  /// Algeria (DZ).
  algeria('DZ'),

  /// Andorra (AD).
  andorra('AD'),

  /// Angola (AO).
  angola('AO'),

  /// Antigua and Barbuda (AG).
  antiguaAndBarbuda('AG'),

  /// Argentina (AR).
  argentina('AR'),

  /// Armenia (AM).
  armenia('AM'),

  /// Aruba (AW).
  aruba('AW'),

  /// Australia (AU).
  australia('AU'),

  /// Austria (AT).
  austria('AT'),

  /// Azerbaijan (AZ).
  azerbaijan('AZ'),

  /// Bahamas (BS).
  bahamas('BS'),

  /// Bahrain (BH).
  bahrain('BH'),

  /// Bangladesh (BD).
  bangladesh('BD'),

  /// Barbados (BB).
  barbados('BB'),

  /// Belarus (BY).
  belarus('BY'),

  /// Belgium (BE).
  belgium('BE'),

  /// Belize (BZ).
  belize('BZ'),

  /// Benin (BJ).
  benin('BJ'),

  /// Bermuda (BM).
  bermuda('BM'),

  /// Bhutan (BT).
  bhutan('BT'),

  /// Bolivia (BO).
  bolivia('BO'),

  /// Bosnia and Herzegovina (BA).
  bosnia('BA'),

  /// Botswana (BW).
  botswana('BW'),

  /// Brazil (BR).
  brazil('BR'),

  /// British Indian Ocean Territory (IO).
  britishIndianOceanTerritory('IO'),

  /// Brunei (BN).
  brunei('BN'),

  /// Bulgaria (BG).
  bulgaria('BG'),

  /// Burkina Faso (BF).
  burkinaFaso('BF'),

  /// Burundi (BI).
  burundi('BI'),

  /// Cambodia (KH).
  cambodia('KH'),

  /// Cameroon (CM).
  cameroon('CM'),

  /// Canada (CA).
  canada('CA'),

  /// Central African Republic (CF).
  centralAfricanRepublic('CF'),

  /// Chile (CL).
  chile('CL'),

  /// China (CN).
  china('CN'),

  /// Christmas Island (CX).
  christmasIsland('CX'),

  /// Cocos Islands (CC).
  cocosIslands('CC'),

  /// Colombia (CO).
  colombia('CO'),

  /// Comoros (KM).
  comoros('KM'),

  /// Cook Islands (CK).
  cookIslands('CK'),

  /// Costa Rica (CR).
  costaRica('CR'),

  /// Croatia (HR).
  croatia('HR'),

  /// Cuba (CU).
  cuba('CU'),

  /// Curaçao (CW).
  curacao('CW'),

  /// Cyprus (CY).
  cyprus('CY'),

  /// Czech Republic (CZ).
  czechRepublic('CZ'),

  /// Democratic Republic of the Congo (CD).
  democraticRepublicOfCongo('CD'),

  /// Denmark (DK).
  denmark('DK'),

  /// Djibouti (DJ).
  djibouti('DJ'),

  /// Dominica (DM).
  dominica('DM'),

  /// Dominican Republic (DO).
  dominicanRepublic('DO'),

  /// East Timor / Timor-Leste (TL).
  eastTimor('TL'),

  /// Ecuador (EC).
  ecuador('EC'),

  /// Egypt (EG).
  egypt('EG'),

  /// Equatorial Guinea (GQ).
  equatorialGuinea('GQ'),

  /// Eritrea (ER).
  eritrea('ER'),

  /// Estonia (EE).
  estonia('EE'),

  /// Ethiopia (ET).
  ethiopia('ET'),

  /// Faroe Islands (FO).
  faroeIslands('FO'),

  /// Fiji (FJ).
  fiji('FJ'),

  /// Finland (FI).
  finland('FI'),

  /// France (FR).
  france('FR'),

  /// French Polynesia (PF).
  frenchPolynesia('PF'),

  /// Gabon (GA).
  gabon('GA'),

  /// Gambia (GM).
  gambia('GM'),

  /// Georgia (GE).
  georgia('GE'),

  /// Germany (DE).
  germany('DE'),

  /// Ghana (GH).
  ghana('GH'),

  /// Gibraltar (GI).
  gibraltar('GI'),

  /// Greece (GR).
  greece('GR'),

  /// Greenland (GL).
  greenland('GL'),

  /// Grenada (GD).
  grenada('GD'),

  /// Guam (GU).
  guam('GU'),

  /// Guatemala (GT).
  guatemala('GT'),

  /// Guernsey (GG).
  guernsey('GG'),

  /// Guinea-Bissau (GW).
  guineaBissau('GW'),

  /// Guinea (GN).
  guinea('GN'),

  /// Guyana (GY).
  guyana('GY'),

  /// Haiti (HT).
  haiti('HT'),

  /// Honduras (HN).
  honduras('HN'),

  /// Hong Kong (HK).
  hongKong('HK'),

  /// Hungary (HU).
  hungary('HU'),

  /// Iceland (IS).
  iceland('IS'),

  /// India (IN).
  india('IN'),

  /// Indonesia (ID).
  indonesia('ID'),

  /// Iran (IR).
  iran('IR'),

  /// Iraq (IQ).
  iraq('IQ'),

  /// Ireland (IE).
  ireland('IE'),

  /// Isle of Man (IM).
  isleOfMan('IM'),

  /// Israel (IL).
  israel('IL'),

  /// Italy (IT).
  italy('IT'),

  /// Jamaica (JM).
  jamaica('JM'),

  /// Japan (JP).
  japan('JP'),

  /// Jersey (JE).
  jersey('JE'),

  /// Jordan (JO).
  jordan('JO'),

  /// Kazakhstan (KZ).
  kazakhstan('KZ'),

  /// Kenya (KE).
  kenya('KE'),

  /// Kiribati (KI).
  kiribati('KI'),

  /// Kuwait (KW).
  kuwait('KW'),

  /// Kyrgyzstan (KG).
  kyrgyzstan('KG'),

  /// Laos (LA).
  laos('LA'),

  /// Latvia (LV).
  latvia('LV'),

  /// Lebanon (LB).
  lebanon('LB'),

  /// Lesotho (LS).
  lesotho('LS'),

  /// Liberia (LR).
  liberia('LR'),

  /// Libya (LY).
  libya('LY'),

  /// Liechtenstein (LI).
  liechtenstein('LI'),

  /// Lithuania (LT).
  lithuania('LT'),

  /// Luxembourg (LU).
  luxembourg('LU'),

  /// Macao (MO).
  macao('MO'),

  /// Madagascar (MG).
  madagascar('MG'),

  /// Malawi (MW).
  malawi('MW'),

  /// Malaysia (MY).
  malaysia('MY'),

  /// Maldives (MV).
  maldives('MV'),

  /// Mali (ML).
  mali('ML'),

  /// Malta (MT).
  malta('MT'),

  /// Martinique (MQ).
  martinique('MQ'),

  /// Mauritania (MR).
  mauritania('MR'),

  /// Mauritius (MU).
  mauritius('MU'),

  /// Mexico (MX).
  mexico('MX'),

  /// Micronesia (FM).
  micronesia('FM'),

  /// Moldova (MD).
  moldova('MD'),

  /// Monaco (MC).
  monaco('MC'),

  /// Mongolia (MN).
  mongolia('MN'),

  /// Montenegro (ME).
  montenegro('ME'),

  /// Montserrat (MS).
  montserrat('MS'),

  /// Morocco (MA).
  morocco('MA'),

  /// Mozambique (MZ).
  mozambique('MZ'),

  /// Myanmar (MM).
  myanmar('MM'),

  /// Namibia (NA).
  namibia('NA'),

  /// Nauru (NR).
  nauru('NR'),

  /// Nepal (NP).
  nepal('NP'),

  /// Netherlands (NL).
  netherlands('NL'),

  /// New Zealand (NZ).
  newZealand('NZ'),

  /// Nicaragua (NI).
  nicaragua('NI'),

  /// Niger (NE).
  niger('NE'),

  /// Nigeria (NG).
  nigeria('NG'),

  /// Niue (NU).
  niue('NU'),

  /// North Macedonia (MK).
  northMacedonia('MK'),

  /// Norway (NO).
  norway('NO'),

  /// Oman (OM).
  oman('OM'),

  /// Pakistan (PK).
  pakistan('PK'),

  /// Palau (PW).
  palau('PW'),

  /// Palestine (PS).
  palestine('PS'),

  /// Panama (PA).
  panama('PA'),

  /// Papua New Guinea (PG).
  papuaNewGuinea('PG'),

  /// Paraguay (PY).
  paraguay('PY'),

  /// Peru (PE).
  peru('PE'),

  /// Philippines (PH).
  philippines('PH'),

  /// Poland (PL).
  poland('PL'),

  /// Portugal (PT).
  portugal('PT'),

  /// Puerto Rico (PR).
  puertoRico('PR'),

  /// Qatar (QA).
  qatar('QA'),

  /// Republic of the Congo (CG).
  republicOfCongo('CG'),

  /// Romania (RO).
  romania('RO'),

  /// Russia (RU).
  russia('RU'),

  /// Rwanda (RW).
  rwanda('RW'),

  /// Saba (BQ).
  saba('BQ'),

  /// Saint Kitts and Nevis (KN).
  saintKittsAndNevis('KN'),

  /// Saint Lucia (LC).
  saintLucia('LC'),

  /// Saint Vincent and the Grenadines (VC).
  saintVincentAndGrenadines('VC'),

  /// Samoa (WS).
  samoa('WS'),

  /// San Marino (SM).
  sanMarino('SM'),

  /// São Tomé and Príncipe (ST).
  saoTomeAndPrincipe('ST'),

  /// Saudi Arabia (SA).
  saudiArabia('SA'),

  /// Senegal (SN).
  senegal('SN'),

  /// Serbia (RS).
  serbia('RS'),

  /// Seychelles (SC).
  seychelles('SC'),

  /// Sierra Leone (SL).
  sierraLeone('SL'),

  /// Singapore (SG).
  singapore('SG'),

  /// Sint Maarten (SX).
  sintMaarten('SX'),

  /// Slovakia (SK).
  slovakia('SK'),

  /// Slovenia (SI).
  slovenia('SI'),

  /// Solomon Islands (SB).
  solomonIslands('SB'),

  /// Somalia (SO).
  somalia('SO'),

  /// South Africa (ZA).
  southAfrica('ZA'),

  /// South Korea (KR).
  southKorea('KR'),

  /// South Sudan (SS).
  southSudan('SS'),

  /// Spain (ES).
  spain('ES'),

  /// Sri Lanka (LK).
  sriLanka('LK'),

  /// Sudan (SD).
  sudan('SD'),

  /// Suriname (SR).
  suriname('SR'),

  /// Swaziland / Eswatini (SZ).
  swaziland('SZ'),

  /// Sweden (SE).
  sweden('SE'),

  /// Switzerland (CH).
  switzerland('CH'),

  /// Syria (SY).
  syria('SY'),

  /// Taiwan (TW).
  taiwan('TW'),

  /// Tajikistan (TJ).
  tajikistan('TJ'),

  /// Tanzania (TZ).
  tanzania('TZ'),

  /// Thailand (TH).
  thailand('TH'),

  /// Togo (TG).
  togo('TG'),

  /// Tokelau (TK).
  tokelau('TK'),

  /// Tonga (TO).
  tonga('TO'),

  /// Trinidad and Tobago (TT).
  trinidadAndTobago('TT'),

  /// Tunisia (TN).
  tunisia('TN'),

  /// Turkey (TR).
  turkey('TR'),

  /// Turkmenistan (TM).
  turkmenistan('TM'),

  /// Tuvalu (TV).
  tuvalu('TV'),

  /// Uganda (UG).
  uganda('UG'),

  /// Ukraine (UA).
  ukraine('UA'),

  /// United Arab Emirates (AE).
  unitedArabEmirates('AE'),

  /// United Kingdom (GB).
  unitedKingdom('GB'),

  /// United States (US).
  unitedStates('US'),

  /// United States Virgin Islands (VI).
  usVirginIslands('VI'),

  /// Uruguay (UY).
  uruguay('UY'),

  /// Uzbekistan (UZ).
  uzbekistan('UZ'),

  /// Vanuatu (VU).
  vanuatu('VU'),

  /// Venezuela (VE).
  venezuela('VE'),

  /// Vietnam (VN).
  vietnam('VN'),

  /// Western Sahara (EH).
  westernSahara('EH'),

  /// Yemen (YE).
  yemen('YE'),

  /// Zambia (ZM).
  zambia('ZM'),

  /// Zimbabwe (ZW).
  zimbabwe('ZW');

  const GHCountry(this.isoCode);

  /// The ISO 3166-1 alpha-2 code for this country (e.g. `'US'`).
  final String isoCode;

  /// The Unicode flag emoji derived from [isoCode].
  ///
  /// Composed from two regional indicator symbols (U+1F1E6–U+1F1FF), one per
  /// letter of the alpha-2 code. Renders as the country's flag on supported
  /// platforms (iOS, Android, macOS, web).
  String get flagEmoji {
    const base = 0x1F1E6;
    return String.fromCharCodes(isoCode.toUpperCase().codeUnits.map((c) => base + c - 0x41));
  }

  /// Returns the [GHCountry] whose [isoCode] matches [code] (case-insensitive),
  /// or `null` if no match is found.
  static GHCountry? fromIsoCode(String code) {
    final upper = code.toUpperCase();
    for (final country in GHCountry.values) {
      if (country.isoCode == upper) return country;
    }
    return null;
  }
}
