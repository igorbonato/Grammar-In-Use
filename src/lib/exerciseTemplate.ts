export type TemplateSegment =
  | { type: 'text'; value: string }
  | { type: 'blank'; blankIndex: number }

/** Splits a sentence template like 'The sun {0} in the west.' into text/blank segments. */
export function parseTemplate(template: string): TemplateSegment[] {
  const segments: TemplateSegment[] = []
  const pattern = /\{(\d+)\}/g
  let lastIndex = 0
  let match: RegExpExecArray | null

  while ((match = pattern.exec(template)) !== null) {
    if (match.index > lastIndex) {
      segments.push({ type: 'text', value: template.slice(lastIndex, match.index) })
    }
    segments.push({ type: 'blank', blankIndex: Number(match[1]) })
    lastIndex = match.index + match[0].length
  }
  if (lastIndex < template.length) {
    segments.push({ type: 'text', value: template.slice(lastIndex) })
  }
  return segments
}
