import type { Module } from '../types/grammar'

export const modules: Module[] = [
  {
    id: 'present-past',
    title: 'Present and past',
    units: [
      { id: 'unit-1', title: 'Present continuous (I am doing)', shortTitle: 'Unit 1' },
      { id: 'unit-2', title: 'Present simple (I do)', shortTitle: 'Unit 2' },
      { id: 'unit-3', title: 'Present continuous and present simple 1', shortTitle: 'Unit 3' },
      { id: 'unit-4', title: 'Present continuous and present simple 2', shortTitle: 'Unit 4' },
      { id: 'unit-5', title: 'Past simple (I did)', shortTitle: 'Unit 5' },
      { id: 'unit-6', title: 'Past continuous (I was doing)', shortTitle: 'Unit 6' },
    ],
  },
  {
    id: 'present-perfect',
    title: 'Present perfect and past',
    units: [
      { id: 'unit-7', title: 'Present perfect 1 (I have done)', shortTitle: 'Unit 7' },
      { id: 'unit-8', title: 'Present perfect 2 (I have done)', shortTitle: 'Unit 8' },
      { id: 'unit-9', title: 'Present perfect continuous', shortTitle: 'Unit 9' },
    ],
  },
  {
    id: 'future',
    title: 'Future',
    units: [
      { id: 'unit-19', title: "Future: I'm going to (do)", shortTitle: 'Unit 19' },
      { id: 'unit-20', title: 'Future: will/shall 1', shortTitle: 'Unit 20' },
      { id: 'unit-21', title: 'Future: will/shall 2', shortTitle: 'Unit 21' },
    ],
  },
  {
    id: 'modals',
    title: 'Modals',
    units: [
      { id: 'unit-27', title: 'Can, could and (be) able to', shortTitle: 'Unit 27' },
      { id: 'unit-28', title: 'Could (do) and could have (done)', shortTitle: 'Unit 28' },
      { id: 'unit-29', title: "Must and can't", shortTitle: 'Unit 29' },
    ],
  },
]
