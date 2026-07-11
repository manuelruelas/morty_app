import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morty_app/core/network/api_client.dart';
import 'package:morty_app/features/character/data/datasources/remote/character_remote_data_source.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockDio extends Mock implements Dio {}

void main() {
  late CharacterRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;
  late MockDio mockDio;

  setUp(() {
    mockApiClient = MockApiClient();
    mockDio = MockDio();
    when(() => mockApiClient.dio).thenReturn(mockDio);
    dataSource = CharacterRemoteDataSourceImpl(mockApiClient);
  });

  test('retorna lista de personajes cuando la respuesta es correcta', () async {
    when(
      () => mockDio.get<Map<String, dynamic>>(
        '/character',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer(
      (_) async => Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: '/character'),
        data: {
          'info': {'count': 1, 'pages': 1, 'next': null, 'prev': null},
          'results': [
            {
              'id': 1,
              'name': 'Rick Sanchez',
              'status': 'Alive',
              'species': 'Human',
              'type': '',
              'gender': 'Male',
              'image':
                  'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              'origin': {
                'name': 'Earth (C-137)',
                'url': 'https://rickandmortyapi.com/api/location/1',
              },
              'location': {
                'name': 'Citadel of Ricks',
                'url': 'https://rickandmortyapi.com/api/location/3',
              },
              'episode': ['https://rickandmortyapi.com/api/episode/1'],
            },
          ],
        },
        statusCode: 200,
      ),
    );

    final result = await dataSource.getCharacters(page: 1, name: 'rick');

    expect(result, hasLength(1));
    expect(result.first.name, 'Rick Sanchez');

    verify(
      () => mockDio.get<Map<String, dynamic>>(
        '/character',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).called(1);
  });

  test('retorna lista vacia cuando Dio lanza 404', () async {
    when(
      () => mockDio.get<Map<String, dynamic>>(
        '/character',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/character'),
        response: Response(
          requestOptions: RequestOptions(path: '/character'),
          statusCode: 404,
          data: {'error': 'There is nothing here'},
        ),
        type: DioExceptionType.badResponse,
      ),
    );

    final result = await dataSource.getCharacters(page: 1, name: 'zzzz');

    expect(result, isEmpty);
  });

  test('lanza excepcion cuando Dio falla con otro error', () async {
    when(
      () => mockDio.get<Map<String, dynamic>>(
        '/character',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/character'),
        response: Response(
          requestOptions: RequestOptions(path: '/character'),
          statusCode: 500,
          data: {'error': 'server error'},
        ),
        type: DioExceptionType.badResponse,
      ),
    );

    expect(() => dataSource.getCharacters(page: 1), throwsException);
  });
}
