import React from 'react';
import {View, Text, StyleSheet, ScrollView, TouchableOpacity} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const COLORS = {
  primary: '#00D9FF',
  secondary: '#7B2FFF',
  accent: '#00FF88',
  pink: '#FF006E',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
};

const environments = [
  {
    name: 'Kali Rolling',
    type: 'kali',
    status: 'Running',
    size: '2.4 GB',
    packages: 47,
    color: COLORS.pink,
    icon: 'shield-lock',
  },
  {
    name: 'Termux Main',
    type: 'termux',
    status: 'Stopped',
    size: '520 MB',
    packages: 12,
    color: COLORS.accent,
    icon: 'console',
  },
];

const LinuxScreen = () => {
  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>Linux Environments</Text>
      
      {environments.map((env, index) => (
        <View key={index} style={styles.card}>
          <View style={styles.cardHeader}>
            <View style={[styles.iconBox, {backgroundColor: env.color + '20'}]}>
              <Icon name={env.icon} size={28} color={env.color} />
            </View>
            <View style={styles.cardInfo}>
              <Text style={styles.envName}>{env.name}</Text>
              <View style={styles.statusRow}>
                <View style={[styles.statusDot, {backgroundColor: env.status === 'Running' ? COLORS.accent : COLORS.textSecondary}]} />
                <Text style={styles.statusText}>{env.status}</Text>
              </View>
            </View>
          </View>
          
          <View style={styles.chips}>
            <View style={styles.chip}>
              <Icon name="harddisk" size={14} color={COLORS.textSecondary} />
              <Text style={styles.chipText}>{env.size}</Text>
            </View>
            <View style={styles.chip}>
              <Icon name="package-variant" size={14} color={COLORS.textSecondary} />
              <Text style={styles.chipText}>{env.packages} packages</Text>
            </View>
          </View>
          
          <View style={styles.buttons}>
            <TouchableOpacity style={[styles.button, {backgroundColor: COLORS.accent}]}>
              <Icon name="play" size={16} color={COLORS.background} />
              <Text style={[styles.buttonText, {color: COLORS.background}]}>Start</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.buttonOutline}>
              <Icon name="stop" size={16} color={COLORS.textPrimary} />
              <Text style={styles.buttonTextOutline}>Stop</Text>
            </TouchableOpacity>
          </View>
        </View>
      ))}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0A0E14',
    padding: 20,
  },
  title: {
    fontSize: 18,
    fontWeight: '600',
    color: COLORS.textPrimary,
    marginBottom: 20,
  },
  card: {
    backgroundColor: COLORS.surface,
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
  },
  cardHeader: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  iconBox: {
    padding: 12,
    borderRadius: 12,
  },
  cardInfo: {
    marginLeft: 16,
    justifyContent: 'center',
  },
  envName: {
    fontSize: 18,
    fontWeight: '600',
    color: COLORS.textPrimary,
  },
  statusRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 4,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginRight: 6,
  },
  statusText: {
    fontSize: 13,
    color: COLORS.textSecondary,
  },
  chips: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  chip: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#1A1F28',
    paddingHorizontal: 10,
    paddingVertical: 6,
    borderRadius: 8,
    marginRight: 12,
  },
  chipText: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginLeft: 6,
  },
  buttons: {
    flexDirection: 'row',
  },
  button: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    borderRadius: 8,
    marginRight: 8,
  },
  buttonOutline: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: COLORS.textSecondary,
  },
  buttonText: {
    fontWeight: '600',
    marginLeft: 6,
  },
  buttonTextOutline: {
    color: COLORS.textPrimary,
    fontWeight: '600',
    marginLeft: 6,
  },
});

export default LinuxScreen;