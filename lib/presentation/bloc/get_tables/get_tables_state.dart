part of 'get_tables_cubit.dart';

enum GetTablesStatus { initial, loading, failed, success }

class GetTablesState extends Equatable {
  const GetTablesState(
      {this.status = GetTablesStatus.initial,
      this.error,
      this.tables = const []});
  final GetTablesStatus status;
  final List<TableEntity> tables;
  final String? error;

  GetTablesState copyWith({
    final GetTablesStatus? status,
    final List<TableEntity>? tables,
    final String? error,
  }) {
    return GetTablesState(
        status: status ?? this.status,
        tables: tables ?? this.tables,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, tables, error];
}
