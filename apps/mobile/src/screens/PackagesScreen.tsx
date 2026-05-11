import React from 'react';
import {View, Text, StyleSheet, FlatList, TouchableOpacity, TextInput} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const COLORS = {
  primary: '#00D9FF',
  secondary: '#7B2FFF',
  accent: '#00FF88',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
  orange: '#FF6B35',
};

const packages = [
  {name: 'python', version: '3.11.4', size: '12 MB', category: 'development', installed: true},
  {name: 'nodejs', version: '20.10.0', size: '28 MB', category: 'development', installed: true},
  {name: 'git', version: '2.43.0', size: '8 MB', category: 'development', installed: true},
  {name: 'nmap', version: '7.94', size: '15 MB', category: 'security', installed: true, hasUpdate: true},
  {name: 'metasploit', version: '6.3.45', size: '180 MB', category: 'security', installed: true},
];

const PackagesScreen = () => {
  return (
    <View style={styles.container}>
      <View style={styles.searchBar}>
        <Icon name="magnify" size={20} color={COLORS.textSecondary} />
        <TextInput
          style={styles.searchInput}
          placeholder="Search packages..."
          placeholderTextColor={COLORS.textSecondary}
        />
      </View>

      <FlatList
        data={packages}
        keyExtractor={(item) => item.name}
        renderItem={({item}) => (
          <View style={styles.packageCard}>
            <View style={[styles.iconBox, {backgroundColor: COLORS.primary + '20'}]}>
              <Icon name="package-variant" size={24} color={COLORS.primary} />
            </View>
            <View style={styles.packageInfo}>
              <Text style={styles.packageName}>{item.name}</Text>
              <Text style={styles.packageVersion}>{item.version} | {item.size}</Text>
            </View>
            {item.hasUpdate && (
              <View style={styles.updateBadge}>
                <Text style={styles.updateText}>Update</Text>
              </View>
            )}
          </View>
        )}
        contentContainerStyle={styles.list}
      />

      <TouchableOpacity style={styles.fab}>
        <Icon name="plus" size={24} color={COLORS.background} />
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0A0E14',
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: COLORS.surface,
    margin: 20,
    padding: 12,
    borderRadius: 12,
  },
  searchInput: {
    flex: 1,
    color: COLORS.textPrimary,
    marginLeft: 12,
  },
  list: {
    paddingHorizontal: 20,
    paddingBottom: 80,
  },
  packageCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: COLORS.surface,
    padding: 16,
    borderRadius: 12,
    marginBottom: 12,
  },
  iconBox: {
    padding: 10,
    borderRadius: 10,
  },
  packageInfo: {
    flex: 1,
    marginLeft: 16,
  },
  packageName: {
    fontSize: 16,
    fontWeight: '600',
    color: COLORS.textPrimary,
  },
  packageVersion: {
    fontSize: 13,
    color: COLORS.textSecondary,
    marginTop: 4,
  },
  updateBadge: {
    backgroundColor: COLORS.orange + '20',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
  },
  updateText: {
    fontSize: 11,
    color: COLORS.orange,
    fontWeight: '600',
  },
  fab: {
    position: 'absolute',
    right: 20,
    bottom: 20,
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: COLORS.primary,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default PackagesScreen;