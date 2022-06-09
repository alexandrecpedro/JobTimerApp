enum ProjectStatus {
  // Attributes
  in_progress(label: 'In progress'),
  finished(label: 'Finished');

  final String label;

  /** Constructor **/
  const ProjectStatus({required this.label});
}
