import React from 'react';
import {StatusBar, useColorScheme} from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

import HomeScreen from './src/screens/HomeScreen';
import TerminalScreen from './src/screens/TerminalScreen';
import LinuxScreen from './src/screens/LinuxScreen';
import PackagesScreen from './src/screens/PackagesScreen';
import SettingsScreen from './src/screens/SettingsScreen';

const Tab = createBottomTabNavigator();

const COLORS = {
  primary: '#00D9FF',
  secondary: '#7B2FFF',
  accent: '#00FF88',
  background: '#0A0E14',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
  error: '#FF4757',
};

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <>
      <StatusBar
        barStyle="light-content"
        backgroundColor={COLORS.background}
      />
      <NavigationContainer>
        <Tab.Navigator
          screenOptions={({route}) => ({
            tabBarIcon: ({focused, color, size}) => {
              let iconName: string;
              switch (route.name) {
                case 'Home':
                  iconName = focused ? 'home' : 'home-outline';
                  break;
                case 'Terminal':
                  iconName = focused ? 'console' : 'console';
                  break;
                case 'Linux':
                  iconName = focused ? 'cloud' : 'cloud-outline';
                  break;
                case 'Packages':
                  iconName = focused ? 'package-variant' : 'package-variant-closed';
                  break;
                case 'Settings':
                  iconName = focused ? 'cog' : 'cog-outline';
                  break;
                default:
                  iconName = 'circle';
              }
              return <Icon name={iconName} size={size} color={color} />;
            },
            tabBarActiveTintColor: COLORS.primary,
            tabBarInactiveTintColor: COLORS.textSecondary,
            tabBarStyle: {
              backgroundColor: COLORS.surface,
              borderTopColor: '#1A1F28',
              height: 60,
              paddingBottom: 8,
              paddingTop: 8,
            },
            headerStyle: {
              backgroundColor: COLORS.background,
            },
            headerTintColor: COLORS.textPrimary,
          })}>
          <Tab.Screen name="Home" component={HomeScreen} />
          <Tab.Screen name="Terminal" component={TerminalScreen} />
          <Tab.Screen name="Linux" component={LinuxScreen} />
          <Tab.Screen name="Packages" component={PackagesScreen} />
          <Tab.Screen name="Settings" component={SettingsScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </>
  );
}

export default App;