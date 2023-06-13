import React from 'react';
import { render, screen } from '@testing-library/react';
import Welcome from "./Welcome";

test('renders welcome', () => {
  render(<Welcome />);
  const h1Element = screen.getByText(/Frontend Template/i);
  expect(h1Element).toBeInTheDocument();
});
