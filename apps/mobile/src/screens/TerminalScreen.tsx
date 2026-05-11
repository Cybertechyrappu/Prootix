import React, {useState} from 'react';
import {View, Text, StyleSheet, TextInput, ScrollView, TouchableOpacity} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const COLORS = {
  primary: '#00D9FF',
  background: '#0D1117',
  surface: '#12161F',
  textPrimary: '#FFFFFF',
  textSecondary: '#B0B8C4',
  terminalGreen: '#00FF41',
};

const TerminalScreen = () => {
  const [lines, setLines] = useState<string[]>([
    'Prootix Linux Environment',
    'Portable Android Workstation',
    '========================================',
    '',
    'Welcome to your Linux environment.',
    'Type "help" for available commands.',
    '',
  ]);
  const [input, setInput] = useState('');

  const handleCommand = (cmd: string) => {
    const newLines = [...lines, `$ ${cmd}`, 'Executing command...'];
    setLines(newLines);
    setInput('');
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.terminal}>
        {lines.map((line, index) => (
          <Text key={index} style={styles.line}>{line}</Text>
        ))}
      </ScrollView>
      <View style={styles.inputBar}>
        <Text style={styles.prompt}>$ </Text>
        <TextInput
          style={styles.input}
          value={input}
          onChangeText={setInput}
          onSubmitEditing={() => handleCommand(input)}
          placeholder="Enter command..."
          placeholderTextColor={COLORS.textSecondary}
          autoCapitalize="none"
          autoCorrect={false}
        />
        <TouchableOpacity onPress={() => handleCommand(input)}>
          <Icon name="send" size={24} color={COLORS.primary} />
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  terminal: {
    flex: 1,
    padding: 16,
  },
  line: {
    fontFamily: 'monospace',
    fontSize: 14,
    color: COLORS.terminalGreen,
    lineHeight: 20,
  },
  inputBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: COLORS.surface,
    padding: 12,
    borderTopWidth: 1,
    borderTopColor: '#1A1F28',
  },
  prompt: {
    color: COLORS.primary,
    fontFamily: 'monospace',
    fontSize: 16,
    fontWeight: 'bold',
  },
  input: {
    flex: 1,
    color: COLORS.textPrimary,
    fontFamily: 'monospace',
    fontSize: 14,
    paddingVertical: 8,
  },
});

export default TerminalScreen;