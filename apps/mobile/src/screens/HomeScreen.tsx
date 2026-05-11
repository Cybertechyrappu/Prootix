import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const COLORS = {
  primary: '#00D9FF',
  secondary: '#7B2FFF',
  accent: '#00FF88',
  background: '#0A0E14',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
};

const HomeScreen = () => {
  const stats = {
    cpu: '12%',
    ram: '35%',
    sessions: 2,
    packages: 47,
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Icon name="terminal" size={32} color={COLORS.primary} />
        <Text style={styles.title}>Prootix</Text>
      </View>

      <View style={styles.statusCard}>
        <View style={styles.statusHeader}>
          <View style={styles.statusDot} />
          <Text style={styles.statusTitle}>Linux Environment Active</Text>
        </View>
        <Text style={styles.statusSubtitle}>Kali Rolling | PRoot Container</Text>
        
        <View style={styles.statsRow}>
          <View style={styles.statItem}>
            <Text style={[styles.statValue, {color: COLORS.primary}]}>{stats.cpu}</Text>
            <Text style={styles.statLabel}>CPU</Text>
          </View>
          <View style={styles.statItem}>
            <Text style={[styles.statValue, {color: COLORS.secondary}]}>{stats.ram}</Text>
            <Text style={styles.statLabel}>RAM</Text>
          </View>
          <View style={styles.statItem}>
            <Text style={[styles.statValue, {color: COLORS.accent}]}>{stats.sessions}</Text>
            <Text style={styles.statLabel}>Sessions</Text>
          </View>
        </View>
      </View>

      <Text style={styles.sectionTitle}>Quick Actions</Text>
      <View style={styles.actionsGrid}>
        <TouchableOpacity style={styles.actionCard}>
          <Icon name="console" size={24} color={COLORS.primary} />
          <Text style={styles.actionText}>New Terminal</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.actionCard}>
          <Icon name="download" size={24} color={COLORS.secondary} />
          <Text style={styles.actionText}>Install Package</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.actionCard}>
          <Icon name="folder" size={24} color={COLORS.accent} />
          <Text style={styles.actionText}>File Manager</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.actionCard}>
          <Icon name="lan-connect" size={24} color="#FF6B35" />
          <Text style={styles.actionText}>SSH Connect</Text>
        </TouchableOpacity>
      </View>

      <Text style={styles.sectionTitle}>Storage</Text>
      <View style={styles.storageCard}>
        <Text style={styles.storageLabel}>Rootfs</Text>
        <Text style={styles.storageValue}>2.4 GB / 10 GB</Text>
        <View style={styles.progressBar}>
          <View style={[styles.progressFill, {width: '24%'}]} />
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
    padding: 20,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 24,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: COLORS.textPrimary,
    marginLeft: 12,
  },
  statusCard: {
    backgroundColor: COLORS.surface,
    borderRadius: 16,
    padding: 20,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: 'rgba(0, 217, 255, 0.2)',
  },
  statusHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  statusDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: COLORS.accent,
    marginRight: 12,
  },
  statusTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: COLORS.textPrimary,
  },
  statusSubtitle: {
    fontSize: 14,
    color: COLORS.textSecondary,
    marginBottom: 16,
  },
  statsRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  statItem: {
    flex: 1,
    backgroundColor: 'rgba(255,255,255,0.05)',
    borderRadius: 12,
    padding: 12,
    marginHorizontal: 4,
    alignItems: 'center',
  },
  statValue: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  statLabel: {
    fontSize: 12,
    color: COLORS.textSecondary,
    marginTop: 4,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: COLORS.textPrimary,
    marginBottom: 12,
  },
  actionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: 24,
  },
  actionCard: {
    width: '48%',
    backgroundColor: COLORS.surface,
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'center',
  },
  actionText: {
    color: COLORS.textPrimary,
    marginLeft: 12,
    fontWeight: '500',
  },
  storageCard: {
    backgroundColor: COLORS.surface,
    borderRadius: 12,
    padding: 16,
    marginBottom: 24,
  },
  storageLabel: {
    fontSize: 14,
    color: COLORS.textSecondary,
  },
  storageValue: {
    fontSize: 16,
    fontWeight: '600',
    color: COLORS.textPrimary,
    marginVertical: 8,
  },
  progressBar: {
    height: 8,
    backgroundColor: '#1A1F28',
    borderRadius: 4,
  },
  progressFill: {
    height: '100%',
    backgroundColor: COLORS.primary,
    borderRadius: 4,
  },
});

export default HomeScreen;