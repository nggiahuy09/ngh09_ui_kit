import 'package:ngh09_ui_kit/src/components/logos/gh_logo_layer.dart';

/// A company whose branding logo is bundled in the Finesse UI Kit.
///
/// Each value carries its natural design width (height is always 48 px in
/// the source Figma file) and the ordered list of SVG layers that compose
/// the logo. Use [GHCompanyLogo] to render any variant.
enum GHCompany {
  /// accenture company logo.
  accenture._(
    140,
    [
    GHLogoLayer('4c73c203ed3a005b94ba43d04160d1752a8255b4', 0.1667, 0.0714, 0.1667, 0.0714),
    ],
  ),

  /// activeCampaign company logo.
  activeCampaign._(
    237,
    [
    GHLogoLayer('5354fed755bb36999c3a0f290ff3119e5b44543c', 0.2854, 0.0026, 0.2146, 0),
    ],
  ),

  /// adobe company logo.
  adobe._(
    133,
    [
    GHLogoLayer('7174ef80f6061b2bfafbdf022ccaa558b98bef59', 0.125, 0.89, 0.1458, 0),
    GHLogoLayer('f33af44c8137264ea79fa6f41778759995896be2', 0.125, 0.7026, 0.1458, 0.1875),
    GHLogoLayer('341398e3fb157cd616339448745ab0142edf66bc', 0.3937, 0.7812, 0.1458, 0.1006),
    GHLogoLayer('caa259d716f681ffb98a1dd1a420ae49389b6454', 0.2896, 0.4816, 0.3044, 0.3849),
    GHLogoLayer('25d791546bfb52ac0de99657e595f100e66df7b0', 0.2556, 0.3718, 0.2983, 0.5276),
    GHLogoLayer('6867a36e17d8b1c6df8b27e1c3b8cad163d007b5', 0.3847, 0.2413, 0.2983, 0.6515),
    GHLogoLayer('aeb4b07f28037d5a993ed7ccfbaf7c195d46c2d7', 0.2556, 0.1176, 0.2983, 0.7823),
    GHLogoLayer('1c91cf74884e1d94d1112f14eb1c6dbe0c19096d', 0.3847, 0.0012, 0.2983, 0.9006),
    ],
  ),

  /// afterpay company logo.
  afterpay._(
    156,
    [
    GHLogoLayer('faa58a98c24a13808c59e588cc39b881d8dbf2cd', 0.25, 0.0045, 0.1458, 0),
    ],
  ),

  /// airbnb company logo.
  airbnb._(
    128,
    [
    GHLogoLayer('502c0bdaabfa1c35c85354cc6af02bb0aa39d076', 0.0833, -0.0013, 0.0833, 0),
    ],
  ),

  /// airtable company logo.
  airtable._(
    154,
    [
    GHLogoLayer('d3a200e7ee96e36d6d5a85409abf5b32f1158831', 0.2772, 0.0014, 0.2741, 0.3128),
    GHLogoLayer('473260c3917ba61972721e34140ff90f5f0c79b2', 0.1449, 0.7555, 0.5562, 0.0151),
    GHLogoLayer('d55fc37bd6d9c415b557bd1c31f30e4b01c4cc56', 0.3502, 0.7402, 0.1781, 0.1384),
    GHLogoLayer('65783c2ebe6b486e7b9e0e8bd97c24426f5715d6', 0.3515, 0.8832, 0.3263, 0),
    GHLogoLayer('3485d0ab2e16a300623d7b8fc632ca0f23f28c35', 0.3515, 0.8832, 0.4346, 0.0021),
    ],
  ),

  /// airtasker company logo.
  airtasker._(
    144,
    [
    GHLogoLayer('3fca1b0d949f6abb74667cef3347b14a588a8e18', 0.2494, 0.0015, 0.2708, 0),
    ],
  ),

  /// airwallex company logo.
  airwallex._(
    168,
    [
    GHLogoLayer('410dfc989fc5a500ecf1fd26bc948cb7fa44d8f1', 0.2507, 0.0018, 0.2708, 0.2325),
    GHLogoLayer('0de9a340587296b7539eb282ac5b7b3d5020af3f', 0.25, 0.7949, 0.2715, 0),
    ],
  ),

  /// algolia company logo.
  algolia._(
    131,
    [
    GHLogoLayer('2acf10e8d52838d0491225c166a10e945de8d379', 0.2045, 0.7238, 0.2059, 0.0589),
    GHLogoLayer('1cb3bd90d729861ac5d2d814fb3209fe406245d7', 0.2875, 0.7676, 0.3162, 0.1064),
    GHLogoLayer('354aa4c4986c8b2ac39e8107a2a81da0f41ad710', 0.2045, 0.0617, 0.2064, 0.3407),
    ],
  ),

  /// amazon company logo.
  amazon._(
    110,
    [
    GHLogoLayer('a3be7b994343854bbe88a6fb4022e709b533c726', 0.6648, 0.3316, 0.0625, 0.1401),
    GHLogoLayer('c79d510fc6160e7d9afe6f8e6c3a135be0fdbb1c', 0.25, 0.0045, 0.3439, 0),
    ],
  ),

  /// amplitude company logo.
  amplitude._(
    194,
    [
    GHLogoLayer('b3528094e250e16353e9acfe6afc33565414bf85', 0.263, 0.8901, 0.5337, 0.0713),
    GHLogoLayer('8b94e708fc8e4e7b6db0a6864f8caf3053a340dd', 0.0698, 0.7898, 0.0501, 0.0025),
    GHLogoLayer('0dd8fe224136f97b4e506928384a5dd4f2101444', 0.256, 0.6523, 0.2938, 0.2357),
    GHLogoLayer('87eac78f65dfa475adf9641f5ff9586b2bd1487f', 0.3811, 0.5175, 0.2938, 0.3593),
    GHLogoLayer('917708fb7b685fbe6612222774858170b613acb9', 0.3844, 0.4226, 0.1418, 0.4977),
    GHLogoLayer('173dd873fdd71a181e4d2837036c595acba11dc7', 0.2389, 0.3889, 0.2938, 0.5895),
    GHLogoLayer('6a1c5af9435ee1b4e1ca717dc3581ed5c1d2eca9', 0.2258, 0.3436, 0.2938, 0.6305),
    GHLogoLayer('d040265bd71da879ac34ecb3922b7924062ab7f7', 0.2784, 0.2671, 0.284, 0.6673),
    GHLogoLayer('e2ed8338eeb46833bcee15738753b7f27df499b6', 0.391, 0.1805, 0.284, 0.744),
    GHLogoLayer('6651a52560f2f739d47542d7e504359dc30b103d', 0.2389, 0.0888, 0.2873, 0.8313),
    GHLogoLayer('60d84c5bc5f33beed573de7dda575370a6881af3', 0.3811, 0.0008, 0.284, 0.9227),
    ],
  ),

  /// asana company logo.
  asana._(
    127,
    [
    GHLogoLayer('9dbbd9dc52beb3cfed5ceac0a656fec8263578bb', 0.3516, 0.0068, 0.2851, 0.2622),
    GHLogoLayer('87d884e9627bcec4d4bfae1590a83d99252aa482', 0.2708, 0.7878, 0.2102, 0),
    ],
  ),

  /// atlassian company logo.
  atlassian._(
    178,
    [
    GHLogoLayer('a24359d8db4bd2eabcc71a828fda324ce3b8324c', 0.454, 0.9472, 0.2974, 0),
    GHLogoLayer('13e23ae186e70d119a9d77abdc9928d0e87e80a9', 0.25, 0.8779, 0.2974, 0.0454),
    GHLogoLayer('f54749165fb1fdbeff3080db7e69c8225676ab00', 0.3245, 0.3753, 0.2917, 0.5467),
    GHLogoLayer('6f9c80a36d662f83951c9ce196f428b025fc37cc', 0.3303, 0.0039, 0.2974, 0.9085),
    GHLogoLayer('300b808ef93a7de2f12dc7da96a2a82f6debae5e', 0.3303, 0.2276, 0.2974, 0.749),
    GHLogoLayer('76eff5d332e83adaadc0469b8b15afe819aaf802', 0.3245, 0.278, 0.2917, 0.6441),
    GHLogoLayer('04a663a317148264a0c6e57c431aec96a851adae', 0.3303, 0.5789, 0.2974, 0.3655),
    GHLogoLayer('64b55494f420e4c4b9dcf6ddaa3b09b7b71df13f', 0.3303, 0.6521, 0.2974, 0.2705),
    GHLogoLayer('daac028e2f46647c3db49433892ca74700ba6b78', 0.3303, 0.7286, 0.2974, 0.1706),
    GHLogoLayer('ae5e96d1a0975d4040bcc1326b10a17a0ebdb4af', 0.3303, 0.4685, 0.2974, 0.4306),
    GHLogoLayer('1e7a834cc55c417e4bc049784ab9793808e58e24', 0.3303, 0.1083, 0.2974, 0.7908),
    ],
  ),

  /// attentive company logo.
  attentive._(
    141,
    [
    GHLogoLayer('80ccceeda1ebe50333c3b7c10f9982b2ee346f0b', 0.2292, 0, 0.2631, 0),
    ],
  ),

  /// basecamp company logo.
  basecamp._(
    165,
    [
    GHLogoLayer('dd7a5f1b12c816e5b9821a564c1e1206fdfbf99e', 0.1265, 0.0009, 0.1196, 0),
    ],
  ),

  /// bookingCom company logo.
  bookingCom._(
    165,
    [
    GHLogoLayer('7dfc17cca2f7cfc565a7d762b7d312b4ae546ad5', 0.2574, 0.3807, 0.1732, 0),
    GHLogoLayer('5e1af982292e6f0a4db2243e6d5f1add3d1a8458', 0.385, 0.0041, 0.2881, 0.6295),
    ],
  ),

  /// braze company logo.
  braze._(
    92,
    [
    GHLogoLayer('06103e458504de1539a1630d3422d17991722182', 0.1042, 0, 0, 0),
    ],
  ),

  /// browserStack company logo.
  browserStack._(
    208,
    [
    GHLogoLayer('ff64d29f71ae546ca38210c3801df71693e42a42', 0.125, 0.8269, 0.125, 0),
    GHLogoLayer('3cfe4ce1485e339bb449316d7dd7f6b653449fd3', 0.125, 0.85, 0.2, 0),
    GHLogoLayer('2624c7d8b07d7ea23d9aa343883e3d0767b6a3f8', 0.125, 0.8442, 0.275, 0.0231),
    GHLogoLayer('df7257f76c2254d0f50f902e7f7232cda94dafca', 0.175, 0.85, 0.275, 0.0288),
    GHLogoLayer('12467058dae37e0688859eeec6ea765144159c50', 0.225, 0.8558, 0.275, 0.0288),
    GHLogoLayer('2af68ae92e7032e54baeaf2e8ca3ddc759b67f36', 0.225, 0.8789, 0.375, 0.0288),
    GHLogoLayer('5f5756c84f40fe64a36c823e66cdf0f4789fa3c4', 0.225, 0.8731, 0.425, 0.0462),
    GHLogoLayer('f0916d2e58396f2b34481980a140df104515e121', 0.25, 0.8731, 0.425, 0.0577),
    GHLogoLayer('9cae7ee7dad3cdce40b9222abda2f9f3d968042d', 0.3, 0.8846, 0.425, 0.0577),
    GHLogoLayer('83a5fe1136d3b56410edaed8fe7487bce5af3846', 0.3, 0.8846, 0.425, 0.0577),
    GHLogoLayer('8d33e81e77f2cfc9a7ee4e730ec56196419b12ae', 0.35, 0.8962, 0.575, 0.0865),
    GHLogoLayer('f462eb52d7b4c78f4cf19fe1d8d16f36f687916d', 0.3225, 0.001, 0.2851, 0.2271),
    ],
  ),

  /// calendly company logo.
  calendly._(
    150,
    [
    GHLogoLayer('d11ac4fcbc1f70bcaeb318fa23e56403fa7127d2', 0.2437, 0.0055, 0.11, 0.2663),
    GHLogoLayer('ef2030585589c3b5b76980c3842e0211ee779e3f', 0.2427, 0.8171, 0.286, 0.0302),
    GHLogoLayer('db608fd92a88a57b36bd3e940ada3f82e2928898', 0.3712, 0.8131, 0.4145, 0.0769),
    GHLogoLayer('a43e14e57b145564504f24ccbd9949aac5b9c55d', 0.14, 0.7875, 0.1833, 0),
    GHLogoLayer('6c78813049e89eebc328d715abb8f6bb3c4e7869', 0.3352, 0.814, 0.3783, 0.0654),
    GHLogoLayer('6c78813049e89eebc328d715abb8f6bb3c4e7869', 0.3352, 0.814, 0.3783, 0.0654),
    ],
  ),

  /// canva company logo.
  canva._(
    110,
    [
    GHLogoLayer('0b0b2d221fd6322debebdd8c8d3195d4c8737913', 0.1667, 0.0504, 0.1724, 0.0504),
    GHLogoLayer('40acdafe9505f4dee02fb4db2cfd490858e3f963', 0.1667, 0.0504, 0.1724, 0.0504),
    GHLogoLayer('9c5afa12da02958a1114024d7ba4249a1afacefc', 0.1667, 0.0504, 0.1724, 0.0504),
    GHLogoLayer('e05d9b7732605f193eea668a6bb336941df904f1', 0.1667, 0.0504, 0.1724, 0.0504),
    GHLogoLayer('1544692d6f5b6cf8b04b7b311d592bd061a1a8b9', 0.1667, 0.0504, 0.1724, 0.0504),
    GHLogoLayer('a4a34a69c197244218ba4728b1b17f41476fbf57', 0.1667, 0.0504, 0.1724, 0.0504),
    ],
  ),

  /// carta company logo.
  carta._(
    97,
    [
    GHLogoLayer('dc2469ad86000716d3f48c4a0043a645f2e9f2f4', 0.0732, 0.2859, 0.6992, 0.4408),
    GHLogoLayer('4f12e3e9d92dc25e7a60a664fbfd33b64cdf9a8d', 0.4762, 0.0028, 0, 0.2187),
    GHLogoLayer('fb8b877935458ea23d45f56a79c1854d7b7abc00', 0, 0.3008, 0.5653, 0),
    ],
  ),

  /// cisco company logo.
  cisco._(
    100,
    [
    GHLogoLayer('3189ab93a7ec13ecc3631b0f84bf2375b787728a', 0.6394, 0.1694, 0.0565, 0.1657),
    GHLogoLayer('2256d14c8b3e21061bfc8d21d831879ca440590b', 0.053, 0.0964, 0.4822, 0.0927),
    GHLogoLayer('8ec9bf6397549455d3f5079bc7aa6c2f63a6170f', 0.6447, 0.6423, 0.0618, 0.3221),
    ],
  ),

  /// classpass company logo.
  classpass._(
    189,
    [
    GHLogoLayer('121b8b6d8971be3faab0c44e88201d1a5a8dac96', 0.175, 0.0013, 0.1159, 0.0004),
    ],
  ),

  /// clearbit company logo.
  clearbit._(
    150,
    [
    GHLogoLayer('8ac7618c13a64d3de5aed0d55748508803054f4b', 0.5, 0.7067, 0.0417, 0.1467),
    GHLogoLayer('01c62c7820e1f0a091b832532b4ac74b4f2324d8', 0.0417, 0.7067, 0.5, 0.1467),
    GHLogoLayer('b4318508f413505801a22217b32a506e8b91ea70', 0.0417, 0.8533, 0.0417, 0),
    GHLogoLayer('653af1e0277faebe3a8954bf4f3c49d21903ce35', 0.2769, 0.0106, 0.3258, 0.4107),
    ],
  ),

  /// clickUp company logo.
  clickUp._(
    130,
    [
    GHLogoLayer('30a6f62cfbd9243e888698d91ce128be156f9bf5', 0.2273, 0.086, 0.2319, 0.0888),
    ],
  ),

  /// cloudflare company logo.
  cloudflare._(
    130,
    [
    GHLogoLayer('7db0edfc0565ad35d4bcf4d383e293f359d3bd32', 0.7013, 0.081, 0.1052, 0.072),
    GHLogoLayer('b06d266238ccfcd9e4696f311396d6679d21340b', 0.3177, 0.1039, 0.3837, 0.6204),
    GHLogoLayer('42ebb558a23cbbc0c923ae1b024d5600e8ef6662', 0.1061, 0.1648, 0.3837, 0.5142),
    GHLogoLayer('c8319f440b6d511567258661c73df339a5982405', 0.328, 0.0692, 0.3837, 0.8084),
    ],
  ),

  /// cocaCola company logo.
  cocaCola._(
    110,
    [
    GHLogoLayer('f074c4380d31d74797c2ab90bfecc292bfaaf81e', 0.1667, 0.0455, 0.1667, 0.0364),
    ],
  ),

  /// codecademy company logo.
  codecademy._(
    167,
    [
    GHLogoLayer('75470596f776a4a200055f186c5d0a68e8436c67', 0.4021, 0.8935, 0.2801, 0.0377),
    GHLogoLayer('8a76b7e634b1e03b1e6cac55ac4e70c6a0b6ea31', 0.4021, 0.5014, 0.2801, 0.4298),
    GHLogoLayer('a981f8092582b56ee7680339a9611b08362da73d', 0.4021, 0.0961, 0.2871, 0.7779),
    GHLogoLayer('1f04e9fc8d6d2619814cc910c4f8c16f50221ae2', 0.409, 0.0034, 0.1736, 0.9158),
    GHLogoLayer('9745cb09124518a4e275bb28129784f5d0bc2aba', 0.4022, 0.8033, 0.2802, 0.1197),
    GHLogoLayer('24ae64b06a9bb3a627d404dc11068eeb692a86ba', 0.4021, 0.4177, 0.2801, 0.51),
    GHLogoLayer('4f908f70aa3618abfe6e67d9bfcc7d97f9b37d0e', 0.4021, 0.6217, 0.2802, 0.3016),
    GHLogoLayer('0e999607d661c72ef5f4593f3f73efc82abbeb2c', 0.2842, 0.7132, 0.2808, 0.2106),
    GHLogoLayer('f1ef48960b64bda82594fb598d297860bb42eb07', 0.4021, 0.2366, 0.2802, 0.6868),
    GHLogoLayer('b08c54386e6678cc33f4a29c6776f9f9bf5c4f51', 0.2842, 0.3272, 0.2802, 0.5965),
    GHLogoLayer('5e55fafd639837d8f3ef6372a4aed57e6ea7b7ab', 0.7926, 0.5041, 0.1374, 0.4311),
    GHLogoLayer('ea67b2bbb8838795bb641f7054e27f5bd9f42f85', 0.1334, 0.584, 0.1375, 0),
    ],
  ),

  /// coinbase company logo.
  coinbase._(
    135,
    [
    GHLogoLayer('70ee6f8d5af00812326ad54317845340928912fa', 0.2083, 0.0048, 0.2917, 0),
    ],
  ),

  /// contentful company logo.
  contentful._(
    163,
    [
    GHLogoLayer('d083b8a9a1011bc05e29ed27c5dabf387f6b8937', 0.2626, 0.931, 0.2015, 0),
    GHLogoLayer('aa79268c6128bd4ac902ca50579389016f7af412', 0.1875, 0.8189, 0.5786, 0.0225),
    GHLogoLayer('1dcc8fc29bc1c4982f185c58960968449542add7', 0.6413, 0.8201, 0.125, 0.0222),
    GHLogoLayer('4a37dc461ac98630b15ac3695335a517cc91adb3', 0.2657, 0.9319, 0.583, 0.0233),
    GHLogoLayer('140bc04dfd44243068c89af0c31972366fe8cdc8', 0.644, 0.9324, 0.2046, 0.0229),
    GHLogoLayer('20c22205d002b95801b8bfe6cdb0f20a38d64be0', 0.2523, 0.005, 0.2985, 0.2103),
    ],
  ),

  /// cultureAmp company logo.
  cultureAmp._(
    201,
    [
    GHLogoLayer('08fb1e81f849d44d14dc41b484bcb89d37c93254', 0.25, 0.0036, 0.1458, 0),
    ],
  ),

  /// customerIo company logo.
  customerIo._(
    221,
    [
    GHLogoLayer('63c13dd4ea8ab621d9378a0de81d1c4d720053bc', 0.104, 0.8192, 0.4198, 0.0774),
    GHLogoLayer('7da45fe097aaeca32cf63dd41cb683ca81cfd141', 0.3423, 0.8706, 0.0626, 0),
    GHLogoLayer('26f280be7af948ea3f35df94159bec303721b5bf', 0.3423, 0.7415, 0.0626, 0.1291),
    GHLogoLayer('82df2707b1bf197adee48516b393edd58a69b357', 0.5947, 0.7793, 0.0627, 0.0379),
    GHLogoLayer('2b1600a09b7e1948ef7a869b845ee8243bd963b7', 0.2066, 0.0073, 0.3873, 0.3349),
    ],
  ),

  /// databricks company logo.
  databricks._(
    178,
    [
    GHLogoLayer('2fea8de58c8c2083466df216a06958a8e13ee8e1', 0.2516, 0.0034, 0.281, 0.2003),
    GHLogoLayer('7dfb5f10d6f8bde41ca6526946dceba36f098e01', 0.1667, 0.8399, 0.1875, 0),
    ],
  ),

  /// deel company logo.
  deel._(
    90,
    [
    GHLogoLayer('32968412b465ef98335edafbd07821dfe1647d91', 0.23, 0.1791, 0.2248, 0.768),
    GHLogoLayer('8344151da3d652b7a35c43a8b7f0dee86656958d', 0.2207, 0.7143, 0.2138, 0.0636),
    GHLogoLayer('f545e4485e929bdf07f1646ee410b39b02ccca42', 0.3838, 0.4827, 0.2138, 0.3084),
    GHLogoLayer('6cb9e945675dcc039f7b545753e8304fc9afda20', 0.3838, 0.2529, 0.2138, 0.5382),
    GHLogoLayer('d3c3c9bd41c2edbc5b731c8e4982809e6af34e8a', 0.6419, 0.0743, 0.2247, 0.8545),
    ],
  ),

  /// descript company logo.
  descript._(
    145,
    [
    GHLogoLayer('494e395e1f1ffdc37a9667dcd63b2e326b395eb4', 0.1667, 0.8007, 0.125, 0),
    GHLogoLayer('d029ff505f164dc7edf72e8571ccb48e496f508d', 0.2729, 0.0034, 0.1958, 0.2814),
    ],
  ),

  /// discord company logo.
  discord._(
    171,
    [
    GHLogoLayer('7c1721d69b29b4adeb5c261d17d4ed032ae867da', 0.1679, 0.0026, 0.1446, 0),
    ],
  ),

  /// disney company logo.
  disney._(
    91,
    [
    GHLogoLayer('30c512a928ceeaa7a1af164b22a68e85d4b74647', 0.1667, 0.0879, 0.1667, 0.0879),
    ],
  ),

  /// docker company logo.
  docker._(
    140,
    [
    GHLogoLayer('ddeb523240605d1e43a327d4ca000167658383da', 0.0646, 0.0013, 0.1844, 0),
    ],
  ),

  /// docusign company logo.
  docusign._(
    125,
    [
    GHLogoLayer('68c11ac1f44c782daccafa85e81b106fedd2be0e', 0.25, 0.0005, 0.1875, 0.0037),
    ],
  ),

  /// doorDash company logo.
  doorDash._(
    188,
    [
    GHLogoLayer('718be1d6ec2e6600dc2aff4c402c5daeb2eef066', 0.3125, -0.0012, 0.2329, 0),
    ],
  ),

  /// dribbble company logo.
  dribbble._(
    112,
    [
    GHLogoLayer('e9b877784980ad7177b56abb32f0abb90fa88b8b', 0.1889, 0.0048, 0.2439, 0),
    ],
  ),

  /// drips company logo.
  drips._(
    77,
    [
    GHLogoLayer('4d085b025272fb9689ec971512f0a258fa55ce91', 0.1667, 0.0088, 0.125, 0),
    ],
  ),

  /// dropbox company logo.
  dropbox._(
    163,
    [
    GHLogoLayer('c8f1218874784c9634a2efe6557c14def99efe64', 0.2588, 0.003, 0.1748, 0.2764),
    GHLogoLayer('08677f63f15c34f9bedb677989ae9fe456bbd7d5', 0.1667, 0.769, 0.1667, 0),
    ],
  ),

  /// elastic company logo.
  elastic._(
    128,
    [
    GHLogoLayer('fbac271bef5c3d9b9b9449d8c5ab030afa8de604', 0.0208, 0.6549, 0.0626, 0),
    GHLogoLayer('22836ee9bb6826b32f5f2246099f0cf226e229a0', 0.0579, 0.711, 0.4924, 0.1209),
    GHLogoLayer('fbcce6725e477c7df1cadf35717b261622cb6795', 0.4498, 0.7756, 0.0981, 0.0558),
    GHLogoLayer('6a0b35c1469ef73a5049b1804e3ec44950e5e69d', 0.1339, 0.8799, 0.687, 0.0545),
    GHLogoLayer('ad0fea96aec8e8adcc10483fe7efbf42e9976678', 0.3133, 0.8772, 0.4, 0.0133),
    GHLogoLayer('dacb9a8f76b87cdcbe4540eebdf705bf3aed6074', 0.646, 0.7095, 0.1758, 0.2251),
    GHLogoLayer('e0c5a4efd97b6a9aaae95b3b29ec15e7884610d2', 0.3588, 0.6682, 0.3548, 0.2205),
    GHLogoLayer('36e907986ca0125f12de6092f3f5d36fb55e19cc', 0.2901, -0.0029, 0.2889, 0.3964),
    ],
  ),

  /// evernote company logo.
  evernote._(
    164,
    [
    GHLogoLayer('9a86701c3a32f69d56e847816be88493be1f6008', 0.2702, 0.0035, 0.2959, 0.2416),
    GHLogoLayer('af1c5d2a31c8c05b3f5d30bb7a73ca0d19ed77f3', 0.1496, 0.8119, 0.1007, 0.0005),
    ],
  ),

  /// fedEx company logo.
  fedEx._(
    120,
    [
    GHLogoLayer('33f628534c9c70a84cda426e28f2e4140eac3147', 0.1667, 0.1, 0.1667, 0.1),
    ],
  ),

  /// figma company logo.
  figma._(
    82,
    [
    GHLogoLayer('b770a9e5c6d63459a8105493b8d8eaa95228d143', 0.6605, 0.8355, 0.0184, 0.0079),
    GHLogoLayer('261b7c8f74e07a675e8924b4e54a517129d928cd', 0.3394, 0.8356, 0.3395, 0.0078),
    GHLogoLayer('ded964efdfd34a3dae8492ac74e805aa2e041853', 0.0182, 0.8356, 0.6606, 0.0078),
    GHLogoLayer('c833d6f56d50b2cb9e227ee6944187a85e82dfd9', 0.0182, 0.6797, 0.6608, 0.1637),
    GHLogoLayer('3d3e233f94a088c0d43fc31a0d342d819e401a78', 0.3394, 0.6789, 0.3396, 0.1637),
    GHLogoLayer('7af05c360d74f55b6818b76155c25285bb690e47', 0.2843, 0.3268, 0.2849, 0.4067),
    GHLogoLayer('b0c6ba2cef84e562492abb7185e63d936da809a0', 0.3884, 0.0078, 0.3757, 0.7053),
    ],
  ),

  /// fivetran company logo.
  fivetran._(
    162,
    [
    GHLogoLayer('0778cc62bfb1e96519f1df72560e392afb1ce285', 0.03125, 0.00593, 0.030625, 0),
    ],
  ),

  /// framer company logo.
  framer._(
    135,
    [
    GHLogoLayer('e2f52beea447e989185fe9bc8130dd1fb01c5543', 0.0417, 0.0036, 0.0476, 0),
    ],
  ),

  /// freshworks company logo.
  freshworks._(
    160,
    [
    GHLogoLayer('262969be4026e2a095b0841baad5ac51c56c46a9', 0.1946, 0.75, 0.3604, 0.197),
    GHLogoLayer('6ae8743463282b927d1b66c3acfa18884fdf12ae', 0.3325, 0.6934, 0.3605, 0.2598),
    GHLogoLayer('cb35a0d9ef9d0dc2ecc87bf2a7944186490b3bdd', 0.3314, 0.6115, 0.3571, 0.3109),
    GHLogoLayer('23f4479af3be996bd747b821b7cb107aaa36fb9b', 0.332, 0.533, 0.3577, 0.3987),
    GHLogoLayer('05f78c0a5fc9634c53728ca75dc2975ba688b237', 0.1774, 0.4401, 0.3599, 0.4851),
    GHLogoLayer('a2986321fab89b224167108e2a8b896e13b25537', 0.3353, 0.3122, 0.3604, 0.5707),
    GHLogoLayer('3d8b97b12a985ff1da2c09c44b37fd1d99e059cc', 0.3314, 0.2254, 0.3571, 0.6928),
    GHLogoLayer('5a9657298906aab9afca278359c340d4d48cca8e', 0.3325, 0.1623, 0.3605, 0.791),
    GHLogoLayer('18e33617f44f83d03107b663d018e22f64d89ce2', 0.1774, 0.0798, 0.3599, 0.8492),
    GHLogoLayer('bd6c241528ee6241acf1e82e7df2ff22ca172cf3', 0.332, 0.0025, 0.3577, 0.9292),
    GHLogoLayer('9c146b3445fad564ec7132bc87f58635560bd5df', 0.4173, 0.9034, 0.2397, 0.001),
    GHLogoLayer('34439f269b302a036d2712ee7fca441094be6db3', 0.6013, 0.946, 0.2402, 0.001),
    GHLogoLayer('d90c89decca78971e617dd9bc4f63428bd00ca06', 0.5215, 0.8723, 0.1598, 0.0249),
    GHLogoLayer('23b2c21505478e7ca9c5e53d7db847fefd81af34', 0.6639, 0.9275, 0.1593, 0.0249),
    GHLogoLayer('56c2afb9ae4f1b42e33a5d1b03a94ed458fa65e2', 0.291, 0.8357, 0.3361, 0.0002),
    GHLogoLayer('5ffc7e198739fa14ec3814399017a0dd22fd13e2', 0.4179, 0.9034, 0.3361, 0.0008),
    GHLogoLayer('216d540098f4775434b91b0e6df9ffae049485f8', 0.4179, 0.9032, 0.3981, 0),
    GHLogoLayer('4cf2a5fd01a4db45010954427e0e95c044bd4903', 0.2754, 0.8342, 0.3366, 0.0115),
    GHLogoLayer('3b6869b2bca08fbe2feaa537724f10c934a4ef1c', 0.2854, 0.8376, 0.5443, 0.0115),
    GHLogoLayer('4aecab73ca4dffbcf3f375bde73fce2e4df6561b', 0.2754, 0.8402, 0.5827, 0.0115),
    GHLogoLayer('ae43d469d69d0cc3ad1e020cb3c9b41ab46ae5a0', 0.2965, 0.8342, 0.1565, 0.054),
    GHLogoLayer('acd18b46fabd9c9d53705038ed1e70a557788685', 0.5215, 0.8722, 0.1598, 0.054),
    GHLogoLayer('6602e889d70f5d29adc302c8bff609bf05af57a4', 0.5215, 0.8722, 0.156, 0.0727),
    GHLogoLayer('c4a646cfe45d8d09751e9559bbfda4e598328d6b', 0.291, 0.8294, 0.1942, 0.0542),
    GHLogoLayer('7e017dbb04348a01e17a404221f4ac58b5333e94', 0.291, 0.8357, 0.3361, 0.0542),
    GHLogoLayer('d91cadae3b35381ce586f69921a1cf532bcde858', 0.2965, 0.8342, 0.3366, 0.054),
    GHLogoLayer('64cdc7fb022579533401fa613c0bf038cfb64737', 0.3026, 0.8324, 0.1948, 0.1164),
    GHLogoLayer('05371b92142bf93eac6759915ee02a033ffbdfc3', 0.3115, 0.8296, 0.1942, 0.1278),
    ],
  ),

  /// ghost company logo.
  ghost._(
    104,
    [
    GHLogoLayer('5f4c856d582eed0c20bf32031b6408a7b405faba', 0.1923, 0.0094, 0.1202, 0.0005),
    ],
  ),

  /// gitHub company logo.
  gitHub._(
    135,
    [
    GHLogoLayer('b1ff960dbac3e176d1d6600dcf99ab3275f48d6d', 0.1042, 0.0045, 0.1875, 0),
    ],
  ),

  /// gitlab company logo.
  gitlab._(
    136,
    [
    GHLogoLayer('b69e07205075f2bfe88808f163631e9ac3ff9d87', 0.2855, 0.0039, 0.2823, 0.4391),
    GHLogoLayer('cd3def85a34091c5c9fa62e614b1730e22a3fbcd', 0.3944, 0.7604, 0.0417, 0.1105),
    GHLogoLayer('e1ac9f24ccc6b073d6d217de9645ff101fde6a18', 0.3944, 0.8249, 0.0417, 0.0203),
    GHLogoLayer('0ef24f215ca8cd801993b34b2e987ddc888b6ea5', 0.3944, 0.8251, 0.0421, 0),
    GHLogoLayer('ae4d309fed4ef4ab68768a6cb222e529b495dbc4', 0.0416, 0.8893, 0.6056, 0.0203),
    GHLogoLayer('180dbdb77367adbabc3513a9bc57c72dafee81bc', 0.3944, 0.67, 0.0417, 0.1751),
    GHLogoLayer('28106428f79a4dce84c0f38ff75392085fd93f34', 0.3944, 0.6498, 0.0421, 0.1752),
    GHLogoLayer('6e484bfe20749caed5f2c95a8701531b23b5b9f0', 0.0419, 0.6701, 0.6056, 0.2394),
    ],
  ),

  /// gong company logo.
  gong._(
    123,
    [
    GHLogoLayer('42bd4f71eb72f24d49ce5efdb4b7e9e1fed5af28', 0.0593, 0.6768, 0.0448, 0),
    GHLogoLayer('8c0f6e47221c7b38a643d7abfc10ef9be7804bce', 0.2266, 0.0015, 0.2317, 0.3633),
    ],
  ),

  /// google company logo.
  google._(
    113,
    [
    GHLogoLayer('d1b0cdb1f8b2c7c085d0e53e66198dedb115a29e', 0.3418, 0.5731, 0.273, 0.2627),
    GHLogoLayer('3ccd9bc3e84c45b17dad64a14c65281419ba34d3', 0.3418, 0.396, 0.273, 0.4398),
    GHLogoLayer('42bb82f27938280c337069b92ee5f003b8ba8d46', 0.3418, 0.2264, 0.1004, 0.6168),
    GHLogoLayer('b723858af0d323dcbf6c2792157ae6eadb9ed601', 0.1507, 0.1701, 0.2848, 0.7949),
    GHLogoLayer('f83ef07c56c7f2822a3ceb9bcea5d45ee688f4e2', 0.3417, 0.0041, 0.2731, 0.845),
    GHLogoLayer('c4f339480b2eb15aef94fe0fc9efca4e51695ce3', 0.1287, 0.7512, 0.2731, 0.0012),
    ],
  ),

  /// grammarly company logo.
  grammarly._(
    180,
    [
    GHLogoLayer('cd11267344ae190a6cb5508d030aeb01e431f401', 0.2627, 0.0043, 0.2637, 0.2934),
    GHLogoLayer('50cfd664cd68c09598d97b4a825237117c48630c', 0.0714, 0.7659, 0.0536, 0),
    GHLogoLayer('95b6a229740d36be3ddacbbf5ee30871d4dd40fb', 0.2518, 0.8168, 0.2333, 0.0484),
    ],
  ),

  /// gumroad company logo.
  gumroad._(
    148,
    [
    GHLogoLayer('dfe9e2e0359effe2a077556d32395b852b56083d', 0.3125, 0.0063, 0.2708, 0.0026),
    ],
  ),

  /// gusto company logo.
  gusto._(
    98,
    [
    GHLogoLayer('ae482c9cbce3cf562adc604a4ca223b7883b212d', 0.1667, 0.0089, 0.0625, 0),
    ],
  ),

  /// hashiCorp company logo.
  hashiCorp._(
    151,
    [
    GHLogoLayer('e852489698bc6550bbf0030744f677afafb88a41', 0.0833, 0.0051, 0.0625, 0),
    ],
  ),

  /// hellosign company logo.
  hellosign._(
    167,
    [
    GHLogoLayer('4635dc2754d56c32b14c47a28dbb6f4235c0000b', 0.288, 0.8425, 0.2062, 0),
    GHLogoLayer('1061e7c9421d182130302042b6c57a857e3b289a', 0.3658, 0.0013, 0.284, 0.1938),
    ],
  ),

  /// hopin company logo.
  hopin._(
    115,
    [
    GHLogoLayer('6dabb2f86a0af2e6457c0c0383e41eec8e050932', 0.1929, 0.0046, 0.125, 0.2643),
    GHLogoLayer('bfe516d7b0bad0b20dbb7cd8e054d46ec289641d', 0.1923, 0.7743, 0.2772, 0.0022),
    ],
  ),

  /// hotjar company logo.
  hotjar._(
    113,
    [
    GHLogoLayer('7df06d66154fe3588f625f5da00cad3ff61ccc5a', 0.25, 0.0064, 0.1458, 0.26),
    GHLogoLayer('3f280a77111cb3f3e0f5d0878af53767057f4f83', 0.2507, 0.8267, 0.2919, 0),
    ],
  ),

  /// huawei company logo.
  huawei._(
    165,
    [
    GHLogoLayer('ab5dfb39334fc9f4caeb6189a9eec44d8bc86547', 0.1667, 0.0485, 0.1667, 0.0485),
    ],
  ),

  /// hubspot company logo.
  hubspot._(
    114,
    [
    GHLogoLayer('014d0edcb0279606de711cea53e02a2fb6a53886', 0.273, 0.003, 0.1667, 0),
    GHLogoLayer('8ae5531e4571117f683ab7958db0e3a0e5534f18', 0.1667, 0.0947, 0.1781, 0.6421),
    ],
  ),

  /// ibm company logo.
  ibm._(
    75,
    [
    GHLogoLayer('5799acc89180499ac95202b86f69a330ad246de4', 0, 0, 0, 0),
    ],
  ),

  /// instagram company logo.
  instagram._(
    125,
    [
    GHLogoLayer('f3dc7e1ea75c78afdbf6675a6ddf1deb2c92a78b', 0.2117, 0.0011, 0.0504, 0),
    ],
  ),

  /// intercom company logo.
  intercom._(
    167,
    [
    GHLogoLayer('0f87b07e34545ce69ef3a579040c86d922d23d12', 0.0625, 0.00408, 0.0625, 0),
    ],
  ),

  /// inVision company logo.
  inVision._(
    123,
    [
    GHLogoLayer('487ffafa6d7a3d7c8960442f118b2322bb6bb8aa', 0.3718, 0.001, 0.2622, 0.3197),
    GHLogoLayer('5687b0fcb6db218420784203aa67a124303c98be', 0.0646, 0.6593, 0.0625, 0),
    GHLogoLayer('6233e33bc4e18d491845d1d96e9f628ecbd4ccac', 0.2361, 0.7073, 0.275, 0.0699),
    ],
  ),

  /// lattice company logo.
  lattice._(
    151,
    [
    GHLogoLayer('6d5c75b9a7b18ac8fa531b9231aea87eca08fd30', 0.467, 0.8546, 0.2281, 0),
    GHLogoLayer('72fdeec77725c1194425173c24d6ae2c118b69e1', 0.3377, 0.7229, 0.2281, 0.0409),
    GHLogoLayer('169ff3fbd93aaa0103d7d9da6cf51990c426aadb', 0.2084, 0.682, 0.2281, 0.0818),
    GHLogoLayer('325ea0b1169eb95a4984171d5afcbadab63d64aa', 0.2085, 0.7638, 0.4183, 0.1181),
    GHLogoLayer('650882897a307aef8302dd72c9321496483df76f', 0.266, 0.0013, 0.2855, 0.3942),
    ],
  ),

  /// lemlist company logo.
  lemlist._(
    120,
    [
    GHLogoLayer('41bd34104a5a92b2dabf645f723a8cc2e80d0be4', 0.2576, 0.7656, 0.257, 0.0394),
    GHLogoLayer('734da7ab8f59684a1eebe8caf3fe56859176e834', 0.416, 0.1313, 0.2913, 0.7703),
    GHLogoLayer('a1bd96b550772a18a2ff61007c0499bf62448681', 0.418, 0.3484, 0.2975, 0.4759),
    GHLogoLayer('4435278ca72d03b9d365b7d16f83fd8b5d7115f0', 0.3434, 0.0424, 0.2937, 0.875),
    GHLogoLayer('7a2b1318e5c998dc5dcadcd5b28959dd892d7f58', 0.4175, 0.5434, 0.2915, 0.3432),
    GHLogoLayer('e244e7c11ad9d0a4ab1335cf5ebab95df5f738c0', 0.3058, 0.2947, 0.2975, 0.6797),
    GHLogoLayer('cc3a3b927a2dbf0ad87e25d5e8fe2a9c526c843c', 0.4227, 0.2456, 0.2976, 0.7286),
    GHLogoLayer('28dc154970cc5c08cd49a70c4a90126a60f6bf5e', 0.3058, 0.6778, 0.2976, 0.309),
    GHLogoLayer('dc998f5757a209737eeb28d8c93d2ea42fd2cf42', 0.3026, 0.2419, 0.6192, 0.7254),
    ],
  ),

  /// lg company logo.
  lg._(
    100,
    [
    GHLogoLayer('6ac4f61ae312e1d918aee9998bce6a160a9b1ae1', 0.125, 0.09, 0.125, 0.09),
    ],
  ),

  /// linear company logo.
  linear._(
    148,
    [
    GHLogoLayer('2605d1b444ef5eca8c2a62e1723631eb5c0ba652', 0.0833, 0.7432, 0.125, 0),
    GHLogoLayer('0a68c42b0a0bfadfc2ab73b9f1ec1d6cd274beac', 0.2409, 0.0031, 0.2767, 0.3906),
    ],
  ),

  /// loom company logo.
  loom._(
    117,
    [
    GHLogoLayer('f84376268bbd0aa3338b2c5bed5ee04743d2bc74', 0.1042, 0.6993, 0.1667, 0),
    GHLogoLayer('a0cbc6fb4fdbdd6d6d8a491f2a0aaa923acde6c5', 0.2021, 0.003, 0.254, 0.3819),
    ],
  ),

  /// louisVuitton company logo.
  louisVuitton._(
    290,
    [
    GHLogoLayer('003f0830822a3a2cae1cd3ecd048a0c70005af74', 0.2083, 0.0379, 0.1875, 0.0379),
    ],
  ),

  /// mailchimp company logo.
  mailchimp._(
    168,
    [
    GHLogoLayer('4785f23f150e6faea5e29971efb90bd309457625', 0.0545, 0.0038, 0.008, 0),
    ],
  ),

  /// marketo company logo.
  marketo._(
    120,
    [
    GHLogoLayer('e6aebc406ffc1622eb28c5dde619d5ffa03950e7', 0.1136, 0.6625, 0.1082, 0.0679),
    GHLogoLayer('d78b53c35465b1689d03d9d63d00c12ece8325ce', 0.3712, 0.0648, 0.3655, 0.4133),
    ],
  ),

  /// maze company logo.
  maze._(
    142,
    [
    GHLogoLayer('59f48c100ac1ef2153f0ee17d4e2023822268e5f', 0.2708, 0.0006, 0.1875, 0),
    ],
  ),

  /// medium company logo.
  medium._(
    145,
    [
    GHLogoLayer('447bdf13b3e76b3775c9bc0bb2f85053471f9303', 0.2604, 0.0041, 0.2813, 0),
    ],
  ),

  /// meta company logo.
  meta._(
    165,
    [
    GHLogoLayer('70757e426a8295efc7cebf7a4af01a917fd238cb', 0.1875, 0.0364, 0.1875, 0.0364),
    ],
  ),

  /// microsoft company logo.
  microsoft._(
    164,
    [
    GHLogoLayer('655bbd89b09241273801f8b3c2a53e411ba84936', 0.2391, 0.0009, 0.2847, 0.2772),
    GHLogoLayer('0cf008be1f0a730cce611f245caeeee2329f567c', 0.1252, 0.8986, 0.5285, 0),
    GHLogoLayer('09987e6d389ec6e3c41aa83a51bcaab0c0005847', 0.1252, 0.7867, 0.5285, 0.1119),
    GHLogoLayer('da6094e91cba61ba91910f1056b06dabfea80b46', 0.5077, 0.8986, 0.146, 0),
    GHLogoLayer('28743582feae722c5138b332ec85c22d355e2460', 0.5077, 0.7867, 0.146, 0.1119),
    ],
  ),

  /// miro company logo.
  miro._(
    120,
    [
    GHLogoLayer('1e8d517c912dcb32c2589a8a4d768e4004f161bc', 0.2291, 0.0818, 0.3095, 0.3933),
    GHLogoLayer('ff5d82812dda8b4b9cd5b19aa47a29e78767daf7', 0.2045, 0.6814, 0.2036, 0.0818),
    GHLogoLayer('10bba139601b4938efe5d4ce0bd698f166ba20bd', 0.2833, 0.706, 0.2727, 0.1164),
    ],
  ),

  /// mitsubishi company logo.
  mitsubishi._(
    220,
    [
    GHLogoLayer('a4d9e2e41500bb3ab8b58f6e23ae3a654fd7aa6a', 0.1455, 0.04, 0.1455, 0.04),
    ],
  ),

  /// mondayCom company logo.
  mondayCom._(
    171,
    [
    GHLogoLayer('8b597bad97ec55872e6c09bea9ef4cbc7881d4c2', 0.3746, 0.9212, 0.2708, 0),
    GHLogoLayer('a3f95b2e69b964e8e273c7c35dc53808f4ddfb82', 0.3747, 0.8573, 0.2708, 0.0638),
    GHLogoLayer('832d0ce3bdf66315aae8c592112421e45a4cf26a', 0.5973, 0.834, 0.2691, 0.1277),
    GHLogoLayer('631241a4ce0c7e26ba6e39e8092a3a7319ccc818', 0.5733, 0.004, 0.2747, 0.8169),
    GHLogoLayer('62e250896bb1da44931c87b883481ea2cfda676a', 0.2188, 0.1616, 0.1354, 0.2042),
    ],
  ),

  /// monzo company logo.
  monzo._(
    148,
    [
    GHLogoLayer('7c48c99f0d3c1083b7bb02d3690b7b23071cbe0f', 0.3321, 0.7566, 0.1187, 0.1822),
    GHLogoLayer('751afadefeebff083aa1fde3652b0ba6eef5583e', 0.1938, 0.7566, 0.2927, 0.1217),
    GHLogoLayer('da8745540facde5a0349883edbf54c035cdd870b', 0.3321, 0.9388, 0.1187, 0),
    GHLogoLayer('93e28e56942f3df80fb9677784d1df1133f62e74', 0.1938, 0.8783, 0.2927, 0),
    GHLogoLayer('9b85f56f6cbfeb478820e01bfa95a8eb5bf64ebd', 0.3404, 0.0039, 0.2923, 0.3203),
    ],
  ),

  /// nestle company logo.
  nestle._(
    140,
    [
    GHLogoLayer('82b0f45c15120dc7c59c72f290625c4549e10e3e', 0.125, 0.0643, 0.125, 0.0643),
    ],
  ),

  /// netflix company logo.
  netflix._(
    111,
    [
    GHLogoLayer('262056504bd48d97258124fcb4d7de0734e4ddd9', 0.2083, -0.0001, 0.1667, 0),
    ],
  ),

  /// notion company logo.
  notion._(
    129,
    [
    GHLogoLayer('5d92ae507a575a6009b471d28dece2f02d2e89a2', 0.125, 0.0035, 0.1573, 0),
    ],
  ),

  /// onePassword company logo.
  onePassword._(
    176,
    [
    GHLogoLayer('35f4ae594e4be84fbe38fa88f5867fa00107f96a', 0.1894, 0.0517, 0.2876, 0.0517),
    GHLogoLayer('704f166a61343afadacf381fd1e3d5a7d2fd2942', 0.2975, 0.2433, 0.2527, 0.634),
    GHLogoLayer('6cadedb9f0466500d9ff91ddb81f28511f26e9dc', 0.2412, 0.228, 0.1965, 0.6187),
    GHLogoLayer('ca17969b39d5cfaf11cdf7fe277cedfc88fe1eee', 0.2319, 0.2254, 0.1871, 0.6161),
    GHLogoLayer('e3c7573c4ea87d66b46889af7c7aabd811d542a9', 0.275, 0.228, 0.1965, 0.6197),
    GHLogoLayer('52460fe1719b4a4c80f21e9f65f6063b4e957c02', 0.3537, 0.2587, 0.309, 0.6493),
    GHLogoLayer('c176ebc4b7be7fbaa8d75e3961bfa144d29e4b45', 0.3443, 0.2561, 0.2996, 0.6468),
    GHLogoLayer('1531509d8fbee8512754c73df78e219abb0f415c', 0.4474, 0.2842, 0.4027, 0.6749),
    GHLogoLayer('278e8ef33a00949b8e1d1fe6dbdf74ee94add6fe', 0.4474, 0.2842, 0.4027, 0.6749),
    GHLogoLayer('93b9e844b0d436299422dffde730f16df8ca0b51', 0.438, 0.2817, 0.3933, 0.6723),
    GHLogoLayer('f175e89525fe2db874b6918b4a3f375c8d6c2d17', 0.4099, 0.2945, 0.3464, 0.6851),
    GHLogoLayer('d5b2e0132f194bd9ae581daf441fed5a7d582d82', 0.4005, 0.2945, 0.3558, 0.6851),
    GHLogoLayer('7bdfbbac2345ff0492269778f5215fbe604e70b4', 0.4193, 0.297, 0.3558, 0.6877),
    ],
  ),

  /// opendoor company logo.
  opendoor._(
    134,
    [
    GHLogoLayer('98a97e0dbfbdc226063128e9999aeec68ba454f6', 0.25, 0.0031, 0.1458, 0),
    ],
  ),

  /// outreach company logo.
  outreach._(
    169,
    [
    GHLogoLayer('552235d428c1c6872496e7a1843153abfd5ac4a0', 0.1137, 0.0042, 0.2196, 0),
    ],
  ),

  /// payPal company logo.
  payPal._(
    143,
    [
    GHLogoLayer('19e142a94bbaba3b91949ce451d4daa87af15505', 0.2661, 0.3182, 0.1719, 0.2872),
    GHLogoLayer('354a9b74ce725e28217c5e2e4de308c1e69ec1ab', 0.266, 0.0048, 0.2709, 0.68),
    GHLogoLayer('a49abbf6ce236555ba2c9ce6da1fbfb16c92e62a', 0.1287, 0.8023, 0.1964, 0.0085),
    GHLogoLayer('3945689b89b9ed56f4c4b1c1aaa5448dff439a81', 0.2881, 0.794, 0.1719, 0.0498),
    GHLogoLayer('8b8859f283ca2b83a66374299541c0152b36477e', 0.2651, 0.8144, 0.4666, 0.0645),
    GHLogoLayer('ef7cf102a9656b9f3ef617f610b053c707c48e9e', 0.1042, 0.8133, 0.2522, 0),
    ],
  ),

  /// pendo company logo.
  pendo._(
    128,
    [
    GHLogoLayer('7f062a804b6bbf43e4b468707801415ed5d3ef05', 0.233, 0, 0.162, 0.25),
    GHLogoLayer('ba75b2f4425890edf9cf0ed4857129ba835a2e19', 0.3071, 0.7917, 0.1497, 0),
    ],
  ),

  /// pepsi company logo.
  pepsi._(
    119,
    [
    GHLogoLayer('5ad73e7488da0a88ffda344b9cf9dadbba74b18e', 0.1667, 0.0672, 0.1667, 0.0672),
    ],
  ),

  /// pipedrive company logo.
  pipedrive._(
    162,
    [
    GHLogoLayer('a6c6df034b46e1ac66e9068c0fbfd40d9f2cbc1a', 0.2292, 0.0043, 0.1667, 0),
    ],
  ),

  /// plaid company logo.
  plaid._(
    118,
    [
    GHLogoLayer('921478b5c38c831e32b1bae2f755ecd680dfc1d9', 0.0417, 0.0077, 0.0417, 0.0029),
    ],
  ),

  /// postman company logo.
  postman._(
    152,
    [
    GHLogoLayer('39f2e6c6be3bbe5dec80f6c09edd85d69d8e8083', 0.0264, 0.0027, 0.0153, 0),
    GHLogoLayer('d5ef134778a0ff4202c962f0a3ebd58b248afc72', 0.1956, 0.7512, 0.2094, 0.0593),
    ],
  ),

  /// productboard company logo.
  productboard._(
    230,
    [
    GHLogoLayer('93007c304dfebcd7e088669ec632841eaff744af', 0.25, 0.0058, 0.1667, 0),
    ],
  ),

  /// razorpay company logo.
  razorpay._(
    161,
    [
    GHLogoLayer('59e8de87a97a18459a833943edd3d507536a8808', 0.1232, 0.85, 0.3018, 0.056),
    GHLogoLayer('210906937bdff927f1e8d98ac74a1ab88d16a2d1', 0.2593, 0.0004, 0.1685, 0),
    ],
  ),

  /// rippling company logo.
  rippling._(
    170,
    [
    GHLogoLayer('fcba41a0243515f0f6de4cfef93cc35a2afd370a', 0.2708, 0.0039, 0.2292, 0),
    ],
  ),

  /// segment company logo.
  segment._(
    171,
    [
    GHLogoLayer('60096604138fdcc966dcf41e8929811ba2512dac', 0.2533, 0.0026, 0.1666, 0.3136),
    GHLogoLayer('a3e8e10b9b2741a4aff205008ba78ad79bf6c6c3', 0.09, 0.7814, 0.1458, 0.0125),
    GHLogoLayer('b7dbec20f85e568e306d0081cd317b497123e33e', 0.1815, 0.7689, 0.2373, 0),
    ],
  ),

  /// sendGrid company logo.
  sendGrid._(
    140,
    [
    GHLogoLayer('649ed3f4c32440bd764487442542f65a8f65cacd', 0.4231, 0.8254, 0.2912, 0.0766),
    GHLogoLayer('43d78f3038b6016501b0cf239315411187bd69dc', 0.2803, 0.7765, 0.434, 0.1256),
    GHLogoLayer('567678cc75d8d3c75e7856d84f871d290b58ebe3', 0.3466, 0.0767, 0.2863, 0.251),
    GHLogoLayer('5a2d6c05886283dba707aaa7d93770137c340b67', 0.566, 0.8744, 0.2912, 0.0766),
    GHLogoLayer('5a2d6c05886283dba707aaa7d93770137c340b67', 0.2803, 0.7765, 0.5769, 0.1746),
    ],
  ),

  /// shopify company logo.
  shopify._(
    127,
    [
    GHLogoLayer('0c496d7422d252a65ac78c05e45733126c83a282', 0.1069, 0.7558, 0.1615, 0),
    GHLogoLayer('b71bcf049fed4a35bb5f457e483a3ba2820414b6', 0.1912, 0.7558, 0.1615, 0.1704),
    GHLogoLayer('9a7a35488d38f936f503ecafaf5d5c50d84055d3', 0.3346, 0.8706, 0.2877, 0.0454),
    GHLogoLayer('48b46bc268bd04cee6d0a6738afaa17f6370b983', 0.2513, 0.0047, 0.1431, 0.2831),
    ],
  ),

  /// sketch company logo.
  sketch._(
    130,
    [
    GHLogoLayer('1264fc787e88db958b1af4277194d5479abe7a6f', 0.2916, 0.0441, 0.2767, 0.3335),
    GHLogoLayer('8388d20ee14592ae62abf78cf9ad526ac117838b', 0.2197, 0.7244, 0.2179, 0.0441),
    GHLogoLayer('313dfd74d42b08b68acdf3116041bbcd8767d972', 0.4224, 0.8401, 0.2179, 0.0441),
    GHLogoLayer('e308041d185d06731405c1f680490b043bd224f1', 0.4224, 0.7243, 0.2179, 0.1599),
    GHLogoLayer('0789fa71c5d47d327be0dd2a1edc9ea40f4209ac', 0.4224, 0.7726, 0.2179, 0.0899),
    GHLogoLayer('05a9199ab902c22481a06153b68b24d8b1201e26', 0.2197, 0.8425, 0.5776, 0.0899),
    GHLogoLayer('0959265ac274ce0389915ded381a1a7cbeb8dabf', 0.2197, 0.7726, 0.5776, 0.1598),
    GHLogoLayer('675e510ce581dd80ae801377d72a668c4dd5a63b', 0.2393, 0.7243, 0.5776, 0.225),
    GHLogoLayer('dbd939a0c8efc81d6a961cb9f796c4f56773352d', 0.2393, 0.9053, 0.5776, 0.0441),
    GHLogoLayer('5638d60692f1cbfe97194b2fbacc77d6acb3efe9', 0.2197, 0.7726, 0.5776, 0.0899),
    ],
  ),

  /// slack company logo.
  slack._(
    121,
    [
    GHLogoLayer('5a659d972bbe4f7ba0f274401d764b8cd5e169f2', 0.1928, 0.0024, 0.2792, 0.3134),
    GHLogoLayer('7ad2bc7ad2ec69775b3bb47edff160fced42d029', 0.1813, 0.8845, 0.527, 0),
    GHLogoLayer('1a439d29792e96800740217c7ec25f8a0f878b54', 0.1813, 0.7526, 0.527, 0.132),
    GHLogoLayer('45b5c0ab96b7cee124e32473cbb66d1aa8a12d4c', 0.5147, 0.7526, 0.1937, 0.132),
    GHLogoLayer('fb1e9dd1693e9af4e0054e960440d6c22d7084b1', 0.5147, 0.8845, 0.1937, 0),
    ],
  ),

  /// sonos company logo.
  sonos._(
    115,
    [
    GHLogoLayer('07cbf24735127ff02cf53ab0e0340ed40ef930d9', 0.2919, 0.0011, 0.2498, 0),
    ],
  ),

  /// sony company logo.
  sony._(
    195,
    [
    GHLogoLayer('243f2175617025ae0d5eecbd71084ea364080edc', 0.1875, 0.0513, 0.1875, 0.0564),
    ],
  ),

  /// spaceX company logo.
  spaceX._(
    211,
    [
    GHLogoLayer('7bd333f01c977d6d305b93aff768ae4a509caa2e', 0.3627, 0.184, 0.2917, 0.0011),
    GHLogoLayer('dded75f41bf633123659d6bb248a1ba84b6bf09b', 0.1667, -0.0001, 0.293, 0.6747),
    ],
  ),

  /// splunk company logo.
  splunk._(
    108,
    [
    GHLogoLayer('2afea6e8ae4e7eb468123140a5d014d40fe9c817', 0.2083, 0.0022, 0.1251, 0),
    ],
  ),

  /// spotify company logo.
  spotify._(
    140,
    [
    GHLogoLayer('41fc50e3c77601d409c8d97dbe6fc2a31d6c750a', 0.0641, -0.0008, 0.0609, 0.0005),
    ],
  ),

  /// square company logo.
  square._(
    132,
    [
    GHLogoLayer('9534c48179215f8041abcafc94927dcc1b219b82', 0.1458, 0.0019, 0.1674, 0.0019),
    ],
  ),

  /// squarespace company logo.
  squarespace._(
    220,
    [
    GHLogoLayer('ef8962bd42b7b5fe5c7d1ce7f94445c5d3cec879', 0.2006, 0.0032, 0.1381, 0),
    ],
  ),

  /// stripe company logo.
  stripe._(
    80,
    [
    GHLogoLayer('676f25ce35a2cbcf196f1b8a45fcccf9c3ede98f', 0.1826, 0.0087, 0.1299, 0),
    ],
  ),

  /// tesla company logo.
  tesla._(
    153,
    [
    GHLogoLayer('90b30ad73afb4c59682d77df0055c78b7d94ba39', 0.3127, -0.0021, 0.2711, 0),
    ],
  ),

  /// tikTok company logo.
  tikTok._(
    147,
    [
    GHLogoLayer('1d5007594afac3d4c53fa14cc7ee1beb7c83c30b', 0.1875, 0.0544, 0.1458, 0.0544),
    ],
  ),

  /// tinder company logo.
  tinder._(
    106,
    [
    GHLogoLayer('3915b8e80d26d8fee34f9942412f4bb7c06a0544', 0.209, 0.7994, 0.2705, 0),
    GHLogoLayer('1984ad033d062bdb0bb908d2e950aed5675b5756', 0.2134, 0.0068, 0.2735, 0.2368),
    ],
  ),

  /// toggl company logo.
  toggl._(
    77,
    [
    GHLogoLayer('91565bd5e03d20fea4dd814c75ccf54abb54a9ca', 0.2292, 0.0024, 0.1667, 0),
    ],
  ),

  /// treehouse company logo.
  treehouse._(
    165,
    [
    GHLogoLayer('b2a23ac4bf6848f348e5dbad0c099ea96ed6cc8d', 0.307, -0.0004, 0.2971, 0.2663),
    GHLogoLayer('4d0b4e82aa3a8f0ca0acc75723d2fcb0b3a877f5', 0.1048, 0.7877, 0.0998, 0),
    ],
  ),

  /// trello company logo.
  trello._(
    113,
    [
    GHLogoLayer('358009a74a2fcf7239d28d989d1817bb9b7bdc90', 0.25, 0.7997, 0.2788, 0),
    GHLogoLayer('7505784fd3e34af1ff661f53e17173db61024608', 0.2845, 0.585, 0.2788, 0.2791),
    GHLogoLayer('b09373763801849f4a4839a6123e8f0f2806562e', 0.3763, 0.4864, 0.2788, 0.4304),
    GHLogoLayer('d33905aa7e6496ec93223c7fd0cb8a2bf5b471ed', 0.25, 0.2466, 0.2761, 0.6933),
    GHLogoLayer('06f3a487febd4ecdf8296c6c0d71b38d3d5bb521', 0.25, 0.1607, 0.2761, 0.7791),
    GHLogoLayer('cda0fd71e90fe4a64a81eb8c919765c87f499f23', 0.3743, 0.0017, 0.2708, 0.8591),
    GHLogoLayer('59641b666a5dbc67bea1b2c6818000ee6b263475', 0.3741, 0.339, 0.272, 0.5289),
    ],
  ),

  /// trustpilot company logo.
  trustpilot._(
    156,
    [
    GHLogoLayer('d8c6b6ce7bcbeb4065c629c6593af176fd352b96', 0.3014, 0.0078, 0.1875, 0.2606),
    GHLogoLayer('5dc55a054e7c4a17b11d8f98a04663e37cb1a5e4', 0.0208, 0.7624, 0.245, 0),
    GHLogoLayer('c963565c287fb89763672362de5f06cd90039b05', 0.4744, 0.8295, 0.4186, 0.1189),
    ],
  ),

  /// twilio company logo.
  twilio._(
    101,
    [
    GHLogoLayer('30d605bb22ef324609dfb4ed7c09bf4fe49be0cc', 0.0029, 0.0018, 0.0264, 0.0081),
    ],
  ),

  /// twitch company logo.
  twitch._(
    103,
    [
    GHLogoLayer('de1e6e9dbdbd6b3083d1e03d10b8173dc07d9536', 0.1458, 0.004, 0.1458, 0),
    ],
  ),

  /// typeform company logo.
  typeform._(
    150,
    [
    GHLogoLayer('bf9fab275d2ebf998cafaa2546a8b6dae849edbe', 0.1894, 0.0588, 0.1933, 0.0612),
    ],
  ),

  /// uber company logo.
  uber._(
    72,
    [
    GHLogoLayer('4ad47b960b904bda149249d08ee692e40c9298c4', 0.2292, -0.0002, 0.25, 0),
    ],
  ),

  /// upwork company logo.
  upwork._(
    114,
    [
    GHLogoLayer('47f3e5a81509ff2d835d5ae3d91bac3eb72e2abf', 0.3403, 0.6444, 0.1463, 0),
    GHLogoLayer('00c2feecb2d9cfb803fa5da3891f6aef48745dc8', 0.3456, 0.1501, 0.2888, 0.7603),
    GHLogoLayer('7237b80ec80b397b493841d0154795c5c4c6e934', 0.3507, 0.4161, 0.2886, 0.3546),
    GHLogoLayer('345d666495699f304cde2aaeefbc8a4ba0688957', 0.3403, 0.2556, 0.2775, 0.5823),
    GHLogoLayer('e19cfddb764d64ef66a299105e8d4ff3074883e7', 0.2083, -0.0012, 0.2886, 0.8655),
    ],
  ),

  /// vodafone company logo.
  vodafone._(
    118,
    [
    GHLogoLayer('2049b1c0b06ae1006d076b1c9b71c20db0baf252', 0, 0, 0, 0),
    ],
  ),

  /// walmart company logo.
  walmart._(
    127,
    [
    GHLogoLayer('4d95cffcbc1e89051aa69a68b8ba19484d9875bb', 0, 0, 0, 0),
    ],
  ),

  /// wealthsimple company logo.
  wealthsimple._(
    180,
    [
    GHLogoLayer('229e2d02b416707becc42e6806cea6f4a6be1c09', 0.25, 0.0017, 0.1908, 0),
    ],
  ),

  /// webflow company logo.
  webflow._(
    116,
    [
    GHLogoLayer('28bd16fe95ceb6523ba0d38350e357c3372ccee2', 0.2083, 0.0047, 0.1875, 0),
    ],
  ),

  /// whatsapp company logo.
  whatsapp._(
    156,
    [
    GHLogoLayer('32230579cc5e57464fed113e16c601d28b2a3194', 0.3555, 0.0038, 0.2342, 0.3365),
    GHLogoLayer('4b49c7b4bb9029d2822884ab4e398aaa7350b556', 0.0211, 0.7076, 0.0212, 0),
    GHLogoLayer('66290dbe00adaae4f46f7732b4839bfafcc1c1fc', 0.0954, 0.7304, 0.1201, 0.0282),
    GHLogoLayer('7e1846e1714ffd8507a83c52868ae8d699a229da', 0.2748, 0.7783, 0.2927, 0.0788),
    ],
  ),

  /// wise company logo.
  wise._(
    130,
    [
    GHLogoLayer('3237bf1d4681d503eb17de0a50c751858a418391', 0.2424, 0.0784, 0.2348, 0.0748),
    ],
  ),

  /// wix company logo.
  wix._(
    76,
    [
    GHLogoLayer('c33daa7d24c5d5b205cfc1d5d4ebdd19a7559eb3', 0.0152, 0.0072, 0.0143, 0.0072),
    ],
  ),

  /// youTube company logo.
  youTube._(
    132,
    [
    GHLogoLayer('bc9e57f54aedd0902fb3461d0aa2265484a5d476', 0.1875, 0.6823, 0.2081, 0),
    GHLogoLayer('a8f4e96c999a5b76d7d542eb9086804d0534d46b', 0.2085, 0.0037, 0.2428, 0.3495),
    ],
  ),

  /// zapier company logo.
  zapier._(
    96,
    [
    GHLogoLayer('0641bb144046766d9bb9c3b35038e09267db0144', 0.0232, 0.0083, 0.0693, 0),
    ],
  ),

  /// zendesk company logo.
  zendesk._(
    140,
    [
    GHLogoLayer('45ae93a7fd53ed2ba6dff51f5da0c323b2433b7f', 0.2121, 0.0532, 0.2174, 0.0506),
    ],
  ),

  /// zeplin company logo.
  zeplin._(
    130,
    [
    GHLogoLayer('d78512c2eb9283538c17da14b7407719c32d907a', 0.1212, 0.6087, 0.1231, 0.0357),
    GHLogoLayer('003947ec8c177f6b56b70b7493833b626a946c58', 0.3764, 0.0357, 0.3783, 0.439),
    ],
  ),

  /// zoom company logo.
  zoom._(
    98,
    [
    GHLogoLayer('c1bcb91a4c05d002699d60e6d2eed03ebd5e38df', 0.2917, 0.001, 0.25, 0),
    ],
  ),

  ;

  const GHCompany._(this.naturalWidth, this.layers);

  /// The logo's natural width in the Figma source (height is always 48).
  final double naturalWidth;

  /// The ordered SVG layers that compose the logo.
  final List<GHLogoLayer> layers;
}
