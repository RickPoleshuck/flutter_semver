library flutter_semver;

import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

enum SemanticPart { build, patch, minor, major }

void exec(final SemanticPart semantic) {
  final File pubspecFile = File('pubspec.yaml');
  final String pubspec = pubspecFile.readAsStringSync();
  final oldVersion = loadVersion(pubspec);
  final version = increment(oldVersion, semantic);
  writeVersion(version, pubspec, pubspecFile);
  print('Updated $oldVersion to $semantic $version');
}

void writeVersion(
    final Version version, final String pubspec, final File pubspecFile) {
  final newPubspec = pubspec.replaceFirst(
      RegExp(r'\nversion:[^\n]*\n'), '\nversion: $version\n');
  pubspecFile.writeAsStringSync(newPubspec, flush: true);
}

Version increment(final Version oldVersion, final SemanticPart semantic) {
  late Version version;
  switch (semantic) {
    case SemanticPart.build:
      String verStr =
          '${oldVersion.major}.${oldVersion.minor}.${oldVersion.patch}';
      if (verStr == oldVersion.toString()) {
        verStr += '+1';
      } else {
        if (oldVersion.toString().startsWith('$verStr+')) {
          int build = int.parse('${oldVersion}'.replaceFirst('$verStr+', ''));
          verStr += '+${++build}';
        } else {
          throw Exception('Unable to handle $oldVersion');
        }
      }
      version = Version.parse(verStr);
      break;
    case SemanticPart.patch:
      version = oldVersion.nextPatch;
      break;
    case SemanticPart.minor:
      version = oldVersion.nextMinor;
      break;
    case SemanticPart.major:
      version = oldVersion.nextMajor;
      break;
  }
  return version;
}

Version loadVersion(final String pubspec) {
  final Map? yamlMap = loadYaml(pubspec);

  if (yamlMap == null) {
    throw Exception('Failed to load pubspec.yaml');
  }

  final String? version = yamlMap['version'];
  if (version == null) {
    throw Exception('No initial version set in pubspec.yaml');
  }
  return Version.parse(version);
}
