import 'package:equatable/equatable.dart';
import 'weight_entity.dart';

class BreedEntity extends Equatable {
  final String id;
  final String name;
  final WeightEntity weight;
  final String? cfaUrl;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String temperament;
  final String origin;
  final String countryCodes;
  final String countryCode;
  final String description;
  final String lifeSpan;
  final int indoor;
  final int? lap;
  final String altNames;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int intelligence;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;
  final int vocalisation;
  final int experimental;
  final int hairless;
  final int natural;
  final int rare;
  final int rex;
  final int suppressedTail;
  final int shortLegs;
  final String? wikipediaUrl;
  final int hypoallergenic;
  final String? referenceImageId;
  final bool isFavorite;

  const BreedEntity({
    required this.id,
    required this.name,
    required this.weight,
    this.cfaUrl,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    required this.temperament,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.lifeSpan,
    required this.indoor,
    this.lap,
    required this.altNames,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.experimental,
    required this.hairless,
    required this.natural,
    required this.rare,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    this.wikipediaUrl,
    required this.hypoallergenic,
    this.referenceImageId,
    this.isFavorite = false,
  });

  BreedEntity copyWith({
    String? id,
    String? name,
    WeightEntity? weight,
    String? cfaUrl,
    String? vetstreetUrl,
    String? vcahospitalsUrl,
    String? temperament,
    String? origin,
    String? countryCodes,
    String? countryCode,
    String? description,
    String? lifeSpan,
    int? indoor,
    int? lap,
    String? altNames,
    int? adaptability,
    int? affectionLevel,
    int? childFriendly,
    int? dogFriendly,
    int? energyLevel,
    int? grooming,
    int? healthIssues,
    int? intelligence,
    int? sheddingLevel,
    int? socialNeeds,
    int? strangerFriendly,
    int? vocalisation,
    int? experimental,
    int? hairless,
    int? natural,
    int? rare,
    int? rex,
    int? suppressedTail,
    int? shortLegs,
    String? wikipediaUrl,
    int? hypoallergenic,
    String? referenceImageId,
    bool? isFavorite,
  }) {
    return BreedEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      cfaUrl: cfaUrl ?? this.cfaUrl,
      vetstreetUrl: vetstreetUrl ?? this.vetstreetUrl,
      vcahospitalsUrl: vcahospitalsUrl ?? this.vcahospitalsUrl,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      countryCodes: countryCodes ?? this.countryCodes,
      countryCode: countryCode ?? this.countryCode,
      description: description ?? this.description,
      lifeSpan: lifeSpan ?? this.lifeSpan,
      indoor: indoor ?? this.indoor,
      lap: lap ?? this.lap,
      altNames: altNames ?? this.altNames,
      adaptability: adaptability ?? this.adaptability,
      affectionLevel: affectionLevel ?? this.affectionLevel,
      childFriendly: childFriendly ?? this.childFriendly,
      dogFriendly: dogFriendly ?? this.dogFriendly,
      energyLevel: energyLevel ?? this.energyLevel,
      grooming: grooming ?? this.grooming,
      healthIssues: healthIssues ?? this.healthIssues,
      intelligence: intelligence ?? this.intelligence,
      sheddingLevel: sheddingLevel ?? this.sheddingLevel,
      socialNeeds: socialNeeds ?? this.socialNeeds,
      strangerFriendly: strangerFriendly ?? this.strangerFriendly,
      vocalisation: vocalisation ?? this.vocalisation,
      experimental: experimental ?? this.experimental,
      hairless: hairless ?? this.hairless,
      natural: natural ?? this.natural,
      rare: rare ?? this.rare,
      rex: rex ?? this.rex,
      suppressedTail: suppressedTail ?? this.suppressedTail,
      shortLegs: shortLegs ?? this.shortLegs,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      hypoallergenic: hypoallergenic ?? this.hypoallergenic,
      referenceImageId: referenceImageId ?? this.referenceImageId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    weight,
    cfaUrl,
    vetstreetUrl,
    vcahospitalsUrl,
    temperament,
    origin,
    countryCodes,
    countryCode,
    description,
    lifeSpan,
    indoor,
    lap,
    altNames,
    adaptability,
    affectionLevel,
    childFriendly,
    dogFriendly,
    energyLevel,
    grooming,
    healthIssues,
    intelligence,
    sheddingLevel,
    socialNeeds,
    strangerFriendly,
    vocalisation,
    experimental,
    hairless,
    natural,
    rare,
    rex,
    suppressedTail,
    shortLegs,
    wikipediaUrl,
    hypoallergenic,
    referenceImageId,
    isFavorite,
  ];
}
