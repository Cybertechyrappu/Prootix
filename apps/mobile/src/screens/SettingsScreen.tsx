import React from 'react';
import {View, Text, StyleSheet, ScrollView, Switch, TouchableOpacity} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const COLORS = {
  primary: '#00D9FF',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
};

const SettingsScreen = () => {
  const [darkMode, setDarkMode] = React.useState(true);
  const [notifications, setNotifications] = React.useState(true);
  const [autoStart, setAutoStart] = React.useState(false);

  const SettingItem = ({icon, title, subtitle, value, onValueChange}: any) => (
    <View style={styles.settingItem}>
      <View style={styles.settingIcon}>
        <Icon name={icon} size={20} color={COLORS.primary} />
      </View>
      <View style={styles.settingInfo}>
        <Text style={styles.settingTitle}>{title}</Text>
        <Text style={styles.settingSubtitle}>{subtitle}</Text>
      </View>
      <Switch
        value={value}
        onValueChange={onValueChange}
        trackColor={{false: '#1A1F28', true: COLORS.primary + '40'}}
        thumbColor={value ? COLORS.primary : '#606875'}
      />
    </View>
  );

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.sectionTitle}>Appearance</Text>
      <View style={styles.section}>
        <SettingItem
          icon="theme-light-dark"
          title="Dark Mode"
          subtitle="Use dark theme"
          value={darkMode}
          onValueChange={setDarkMode}
        />
      </View>

      <Text style={styles.sectionTitle}>Behavior</Text>
      <View style={styles.section}>
        <SettingItem
          icon="bell"
          title="Notifications"
          subtitle="Show terminal notifications"
          value={notifications}
          onValueChange={setNotifications}
        />
        <SettingItem
          icon="play-circle"
          title="Auto Start"
          subtitle="Start Linux on app launch"
          value={autoStart}
          onValueChange={setAutoStart}
        />
      </View>

      <Text style={styles.sectionTitle}>Storage</Text>
      <View style={styles.section}>
        <TouchableOpacity style={styles.settingItem}>
          <View style={styles.settingIcon}>
            <Icon name="folder" size={20} color={COLORS.primary} />
          </View>
          <View style={styles.settingInfo}>
            <Text style={styles.settingTitle}>Storage Location</Text>
            <Text style={styles.settingSubtitle}>/data/data/com.prootix</Text>
          </View>
          <Icon name="chevron-right" size={20} color={COLORS.textSecondary} />
        </TouchableOpacity>
        <TouchableOpacity style={styles.settingItem}>
          <View style={styles.settingIcon}>
            <Icon name="delete" size={20} color={COLORS.primary} />
          </View>
          <View style={styles.settingInfo}>
            <Text style={styles.settingTitle}>Clear Cache</Text>
            <Text style={styles.settingSubtitle}>Remove temporary files</Text>
          </View>
          <Icon name="chevron-right" size={20} color={COLORS.textSecondary} />
        </TouchableOpacity>
      </View>

      <Text style={styles.sectionTitle}>About</Text>
      <View style={styles.section}>
        <View style={styles.settingItem}>
          <View style={styles.settingIcon}>
            <Icon name="information" size={20} color={COLORS.primary} />
          </View>
          <View style={styles.settingInfo}>
            <Text style={styles.settingTitle}>Version</Text>
            <Text style={styles.settingSubtitle}>1.0.0 (Build 1)</Text>
          </View>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0A0E14',
    padding: 20,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: COLORS.primary,
    marginTop: 20,
    marginBottom: 12,
  },
  section: {
    backgroundColor: COLORS.surface,
    borderRadius: 16,
    overflow: 'hidden',
  },
  settingItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#1A1F28',
  },
  settingIcon: {
    width: 40,
    height: 40,
    borderRadius: 8,
    backgroundColor: COLORS.primary + '20',
    alignItems: 'center',
    justifyContent: 'center',
  },
  settingInfo: {
    flex: 1,
    marginLeft: 12,
  },
  settingTitle: {
    fontSize: 15,
    fontWeight: '500',
    color: COLORS.textPrimary,
  },
  settingSubtitle: {
    fontSize: 13,
    color: COLORS.textSecondary,
    marginTop: 2,
  },
});

export default SettingsScreen;